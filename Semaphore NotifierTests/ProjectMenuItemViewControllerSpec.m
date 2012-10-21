//
//  ProjectMenuItemViewControllerSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "ProjectMenuItemViewController.h"
#import "SpecHelper.h"

@interface ProjectMenuItemViewController ()
@property (retain, nonatomic) NSNumber *status ;
@property (retain, nonatomic) NSMutableData *receivedData;

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response ;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data ;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error ;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection ;
@end

SpecBegin(ProjectMenuItemViewControllerSpec)

describe(@"ProjectMenuItemViewController", ^{
  __block ProjectMenuItemViewController *controller ;
  __block Project *project ;
  
  beforeEach(^{
    controller = [[ProjectMenuItemViewController alloc] init] ;
    project = [Project projectWithName: @"project name" andKey: @"123a"] ;
    controller.project = project ;
  }) ;

  describe(@"controllerWithProject", ^{
    beforeEach(^{
      controller = [ProjectMenuItemViewController controllerWithProject: project] ;
    }) ;

    it(@"creates a project controller", ^{
      expect(controller).to.beKindOf([ProjectMenuItemViewController class]) ;
    }) ;

    it(@"links it to the project", ^{
      expect(controller.project).to.beIdenticalTo(project) ;
    }) ;
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
        [controller connection: connection didReceiveResponse: response] ;
      }) ;

      it(@"creates a NSData to receive the data", ^{
        expect(controller.receivedData).toNot.beNil() ;
      }) ;

      it(@"resets the receivedata", ^{
        expect([controller.receivedData length]).to.equal(0) ;
      }) ;
    }) ;

    describe(@"didReceiveData", ^{
      __block NSData *data ;

      beforeEach(^{
        data = [@"received data"  dataUsingEncoding:NSUTF8StringEncoding] ;
        controller.receivedData = [NSMutableData data] ;
        
        [controller connection: connection didReceiveData: data] ;
      }) ;

      it(@"appends the received data", ^{
        NSString *decoded = [[NSString alloc] initWithData: controller.receivedData encoding:NSUTF8StringEncoding] ;

        expect(decoded).to.equal(@"received data") ;
      }) ;
    }) ;

    describe(@"didFailWithError", ^{
      __block NSError *error ;

      beforeEach(^{
        error = [[NSError alloc] init] ;

        [controller connection: connection didFailWithError: error] ;
      }) ;

      it(@"sets the controller status to error", ^{
        expect(controller.status).to.equal(ResourceStatusFailure) ;
      }) ;
    }) ;
    describe(@"connectionDidFinishLoading", ^{
      beforeEach(^{
        controller.receivedData = [[@"[{\"id\": \"1\", \"name\": \"branch\"}]"  dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];

        [controller connectionDidFinishLoading: connection] ;
      }) ;

      it(@"sets the controller status to success", ^{
        expect(controller.status).to.equal(ResourceStatusSuccess) ;
      }) ;

      it(@"parses the JSON in the response and load the branches", ^{
        expect([controller.project.branches count]).to.equal(1) ;
      }) ;

      it(@"sets the controller status to error is the json is malformed", ^{
        controller.receivedData = [[@"Failed"  dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];

        [controller connectionDidFinishLoading: connection] ;

        expect(controller.status).to.equal(ResourceStatusFailure) ;
      }) ;
    }) ;
  }) ;
}) ;

SpecEnd