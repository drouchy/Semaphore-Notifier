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

@end

@implementation SemaphoreHttpRequestExecutor

dispatch_queue_t httpRequestQueue ;

+ (void) initialize {
  httpRequestQueue = dispatch_queue_create("net.drouchy.semaphore.notifier.httpRequest", NULL);
}

+ (id) requestForResource: (SemaphoreResource *) aResource {
  SemaphoreHttpRequestExecutor *request = [[self alloc] init] ;
  request.resource = aResource ;
  return request ;
}

- (void) execute: (void (^)())block {
  _executionDoneBlock = block ;

  dispatch_async(httpRequestQueue, ^{
    [self initRequest] ;
  }) ;
}

- (void) initRequest {
  NSURL *url = [self.resource requestUrl] ;
  NSLog(@"opening url %@", url) ;
  
  NSURLRequest *theRequest = [NSURLRequest requestWithURL: url
                                              cachePolicy: NSURLRequestReloadIgnoringLocalCacheData
                                          timeoutInterval: 10.0];
  self.resource.status = ResourceStatusPending ;

  NSURLConnection *theConnection= [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
  
  if (theConnection) {
    CFRunLoopRun();
  } else {
    self.resource.status = ResourceStatusError ;
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
  self.resource.status = ResourceStatusError ;
  CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  NSLog(@"did finish loading (%@)", self.resource) ;
  
  NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: _receivedData options: NSJSONReadingMutableContainers error: nil];
  if(jsonArray) {
    NSLog(@"parsing the JSON message: %@", jsonArray) ;
    [self.resource parseJson: jsonArray] ;
    self.resource.status = ResourceStatusSuccess ;
    [_executionDoneBlock invoke] ;
  } else {
    self.resource.status = ResourceStatusError ;
    NSLog(@"Failed to parse the response (%@)", self.resource) ;
  }
  CFRunLoopStop(CFRunLoopGetCurrent());
}
@end
