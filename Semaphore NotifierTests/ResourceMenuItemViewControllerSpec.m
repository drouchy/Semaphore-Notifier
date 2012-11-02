//
//  ResourceMenuItemViewControllerSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 26/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "ResourceMenuItemViewController.h"
#import "SpecHelper.h"
#import "SemaphoreResource.h"

@interface ResourceMenuItemViewController()

- (Boolean) shouldHideTheErrorImage ;

@end

SharedExamplesBegin(ResourceMenuItemViewControllerSamples)

sharedExamplesFor(@"hidding the error image", ^(NSDictionary *data) {
  __block ResourceMenuItemViewController *controller ;
  
  beforeEach(^{
    ResourceStatus status = [data[@"status"] intValue] ;
    controller = data[@"controller"] ;
    controller.resource.status = status ;
  }) ;
  
  it(@"hides the image", ^{
    expect([controller shouldHideTheErrorImage]).to.beTruthy() ;
  });
});

sharedExamplesFor(@"showing the error image", ^(NSDictionary *data) {
  __block ResourceMenuItemViewController *controller ;
  
  beforeEach(^{
    ResourceStatus status = [data[@"status"] intValue] ;
    controller = data[@"controller"] ;
    controller.resource.status = status ;
  }) ;
  
  it(@"hides the image", ^{
    expect([controller shouldHideTheErrorImage]).to.beFalsy() ;
  });
});

SharedExamplesEnd

SpecBegin(ResourceMenuItemViewControllerSpec)

describe(@"ResourceMenuItemViewController", ^{
  __block ResourceMenuItemViewController *controller ;
  __block SemaphoreResource *resource ;
  
  beforeEach(^{
    controller = [[ResourceMenuItemViewController alloc] init] ;
    resource = [[SemaphoreResource alloc] init] ;
  }) ;
  
  describe(@"initWithResource", ^{
    beforeEach(^{
      controller = [[ResourceMenuItemViewController alloc] initWithResource: resource ] ;
    }) ;
    
    it(@"creates a controller", ^{
      expect(controller).to.beKindOf([ResourceMenuItemViewController class]) ;
    }) ;
    
    it(@"links it to the resource", ^{
      expect(controller.resource).to.beIdenticalTo(resource) ;
    }) ;
  }) ;

  describe(@"shouldHideTheErrorImage", ^{
    beforeEach(^{
      controller.resource = resource ;
    }) ;

    itBehavesLike(@"showing the error image", ^{
      return @{@"controller": controller, @"status": [NSNumber numberWithInt: ResourceStatusError]} ; }) ;
    itBehavesLike(@"showing the error image", ^{
      return @{@"controller": controller, @"status": [NSNumber numberWithInt: ResourceStatusUnknown]} ; }) ;
    
    itBehavesLike(@"hidding the error image", ^{
      return @{ @"controller": controller, @"status": [NSNumber numberWithInt: ResourceStatusLoading] };}) ;
    itBehavesLike(@"hidding the error image", ^{
      return @{@"controller": controller, @"status": [NSNumber numberWithInt: ResourceStatusNone]} ; }) ;
    itBehavesLike(@"hidding the error image", ^{
      return @{@"controller": controller, @"status": [NSNumber numberWithInt: ResourceStatusSuccess]} ; }) ;
    itBehavesLike(@"hidding the error image", ^{
      return @{@"controller": controller, @"status": [NSNumber numberWithInt: ResourceStatusPending]} ; }) ;
    itBehavesLike(@"hidding the error image", ^{
      return @{@"controller": controller, @"status": [NSNumber numberWithInt: ResourceStatusFailure]} ; }) ;
  }) ;

  describe(@"updateResourceStatus", ^{
    beforeEach(^{
      controller.resource = resource ;
    }) ;

    it(@"updates the resource status", ^{
      [controller updateResourceStatus: ResourceStatusSuccess] ;

      expect(controller.resource.status).to.equal(ResourceStatusSuccess) ;
    }) ;

    it(@"sends a KVO notification for the shouldHideErrorImage", ^{
    }) ;
    it(@"sends a KVO notification for the shouldHideTheSubmenuImage", ^{
    }) ;

  }) ;
}) ;

SpecEnd