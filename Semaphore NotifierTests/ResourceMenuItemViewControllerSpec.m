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
}) ;

SpecEnd