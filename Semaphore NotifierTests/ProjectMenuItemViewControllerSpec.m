//
//  ProjectMenuItemViewControllerSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "ProjectMenuItemViewController.h"
#import "SpecHelper.h"
#import "StatusBarMenuItemView.h"

@interface ProjectMenuItemViewController ()
@property (retain, nonatomic) NSNumber *status ;
@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain, nonatomic) NSMenuItem *menuItem;
@property (retain, nonatomic) NSMutableArray *branchesController ;

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response ;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data ;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error ;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection ;

- (void) loadBranches ;
@end

SpecBegin(ProjectMenuItemViewControllerSpec)

describe(@"ProjectMenuItemViewController", ^{
  __weak ProjectMenuItemViewController *controller ;
  __weak Project *project ;
  
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
    __unsafe_unretained id connection ;
    __unsafe_unretained id response ;

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

  describe(@"buildMenuItem", ^{
    __weak NSMenuItem *item ;

    beforeEach(^{
      item = [controller buildMenuItem] ;
    }) ;

    // Still the issue with the class comparison
    pending(@"creates a menu item with a specific view", ^{
      expect([item view]).to.beKindOf([StatusBarMenuItemView class]) ;
    }) ;

    // can't load the controller view
    pending(@"adds a submenuf for the branch list", ^{
      expect(controller.menuItem.submenu).toNot.beNil() ;
    }) ;
  }) ;

  describe(@"loadBranches", ^{
  
    beforeEach(^{
      NSArray *branches = @[ [[Branch alloc] init], [[Branch alloc] init]] ;
      project.branches = [branches mutableCopy] ;
    }) ;

    // can't load the controller view
    pending(@"adds a submenu item for each branch", ^{
      [controller loadBranches] ;
      expect([[controller.menuItem.submenu itemArray] count]).to.equal(2) ;
    }) ;
  }) ;
}) ;

SpecEnd