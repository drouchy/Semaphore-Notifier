//
//  SemaphoreHttpConnectionRequest.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 27/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "SemaphoreHttpRequestExecutor.h"

@interface SemaphoreHttpRequestExecutor()

@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) void (^executionDoneBlock)(void);
@property (strong, nonatomic) void (^updateStatusBlock)(ResourceStatus);

@property (weak) id delegate ;

@end

@implementation SemaphoreHttpRequestExecutor

dispatch_queue_t httpRequestQueue ;

+ (void) initialize {
  httpRequestQueue = dispatch_queue_create("net.drouchy.semaphore.notifier.httpRequest", NULL);
}

+ (id) requestForResource: (SemaphoreResource *) aResource delegate: (id) delegate {
  SemaphoreHttpRequestExecutor *request = [[self alloc] init] ;
  request.resource = aResource ;
  request.delegate = delegate ;
  
  return request ;
}

- (void) execute: (void (^)())block statusBlock: (void (^)(ResourceStatus)) statusBlock{
  _executionDoneBlock = block ;
  _updateStatusBlock = statusBlock ;

  dispatch_async(httpRequestQueue, ^{
    [self initRequest] ;
  }) ;
}

- (void) initRequest {
  [self.resource addObserver: self.delegate
              forKeyPath:@"status"
                 options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                 context:@"KVO_CONTEXT_STATUS_CHANGED"];
  
  NSURL *url = [self.resource requestUrl] ;
  NSLog(@"opening resource %@ url %@", self.resource, url) ;
  
  NSURLRequest *theRequest = [NSURLRequest requestWithURL: url
                                              cachePolicy: NSURLRequestReloadIgnoringLocalCacheData
                                          timeoutInterval: 10.0];
  [self updateResourceStatus: ResourceStatusPending] ;

  NSURLConnection *theConnection= [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
  
  if (theConnection) {
    CFRunLoopRun();
  } else {
    [self updateResourceStatus: ResourceStatusError] ;
    NSLog(@"Error while requesting branches of ResourceStatusPending %@", self.resource) ;
  }
}

#pragma mark NSURLConnection methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  NSLog(@"did receive response (%@)", self.resource) ;
  _receivedData = [[NSMutableData alloc] init];
  [_receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  NSLog(@"did receive data (%@)", self.resource) ;
  NSLog(@"%@", _receivedData) ;
  [_receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  NSLog(@"did fail with error (%@)", self.resource) ;
  [self updateResourceStatus: ResourceStatusError] ;
  CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  NSLog(@"did finish loading (%@)", self.resource) ;
  
  NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: _receivedData options: NSJSONReadingMutableContainers error: nil];
  if(jsonArray) {
    NSLog(@"parsing the JSON message: %@", jsonArray) ;
    [self.resource parseJson: jsonArray] ;
    [self updateResourceStatus: ResourceStatusSuccess] ;
    [_executionDoneBlock invoke] ;
  } else {
    self.resource.status = ResourceStatusError ;
    NSLog(@"Failed to parse the response (%@)", self.resource) ;
  }
  CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void) updateResourceStatus: (ResourceStatus) status {
  //[self performSelectorOnMainThread: @selector(setStatus:) withObject:[NSNumber numberWithInt:status] waitUntilDone:YES] ;
  [self setStatus: status] ;
  self.updateStatusBlock(status) ;
}

- (void) setStatus: (ResourceStatus) status {
  NSLog(@"----> updating status of %@", self.resource) ;
//  [self.resource setStatus:[status intValue]] ;
}
@end
