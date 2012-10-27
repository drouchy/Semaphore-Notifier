//
//  SemaphoreHttpConnectionRequestSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 27/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "SemaphoreHttpRequestExecutor.h"
#import "SpecHelper.h"
#import "Project.h"
#import "SemaphoreResource.h"

@interface SemaphoreHttpRequestExecutor()

@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) void (^executionDoneBlock)(void);

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response ;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data ;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error ;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection ;

@end

SpecBegin(SemaphoreHttpRequestExecutorSpec)

describe(@"SemaphoreHttpRequestExecutor", ^{
  __block SemaphoreHttpRequestExecutor *executor ;
  __block SemaphoreResource *resource ;

  beforeEach(^{
    resource = [[Project alloc] init] ;
    executor = [SemaphoreHttpRequestExecutor requestForResource: resource] ;
  }) ;

  describe(@"NSUrlConnection delegate", ^{
    __block id connection ;
    __block id response ;
    
    beforeEach(^{
      connection = [OCMockObject niceMockForClass:[NSConnection class]] ;
      response = [OCMockObject niceMockForClass:[NSURLResponse class]] ;
    }) ;
    
    describe(@"didReceiveResponse", ^{
      beforeEach(^{
        [executor connection: connection didReceiveResponse: response] ;
      }) ;
      
      it(@"creates a NSData to receive the data", ^{
        expect(executor.receivedData).toNot.beNil() ;
      }) ;
      
      it(@"resets the receivedata", ^{
        expect([executor.receivedData length]).to.equal(0) ;
      }) ;
    }) ;
    
    describe(@"didReceiveData", ^{
      __block NSData *data ;
      
      beforeEach(^{
        data = [@"received data"  dataUsingEncoding:NSUTF8StringEncoding] ;
        executor.receivedData = [NSMutableData data] ;
        
        [executor connection: connection didReceiveData: data] ;
      }) ;
      
      it(@"appends the received data", ^{
        NSString *decoded = [[NSString alloc] initWithData: executor.receivedData encoding:NSUTF8StringEncoding] ;
        
        expect(decoded).to.equal(@"received data") ;
      }) ;
    }) ;
    
    describe(@"didFailWithError", ^{
      __block NSError *error ;
      
      beforeEach(^{
        error = [[NSError alloc] init] ;
        
        [executor connection: connection didFailWithError: error] ;
      }) ;
      
      it(@"sets the controller status to unknown", ^{
        expect(executor.resource.status).to.equal(ResourceStatusError) ;
      }) ;
    }) ;
    
    describe(@"connectionDidFinishLoading", ^{
      beforeEach(^{
        executor.receivedData = [[@"[{\"id\": \"1\", \"name\": \"branch\"}]"  dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        [executor connectionDidFinishLoading: connection] ;
      }) ;
      
      it(@"parses the JSON in the response and load the branches", ^{
        id resource = [OCMockObject niceMockForClass: [SemaphoreResource class]] ;
        executor.resource = resource ;
        [[resource expect] parseJson: [OCMArg any]] ;
  
        [executor connectionDidFinishLoading: connection] ;

        [resource verify] ;
      }) ;
      
      it(@"sets the controller status to error is the json is malformed", ^{
        executor.receivedData = [[@"Failed"  dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        [executor connectionDidFinishLoading: connection] ;
        
        expect(executor.resource.status).to.equal(ResourceStatusError) ;
      }) ;
    }) ;
  }) ;
}) ;
SpecEnd