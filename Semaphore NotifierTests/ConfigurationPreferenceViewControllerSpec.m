//
//  ConfigurationPreferenceViewControllerSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "SpecHelper.h"
#import "ConfigurationPreferenceViewController.h"

SpecBegin(ConfigurationPreferenceViewControllerSpec)

describe(@"ConfigurationPreferenceViewController", ^{
  __block ConfigurationPreferenceViewController *controller ;
  __block Configuration *configuration ;
  
  beforeEach(^{
    controller = [[ConfigurationPreferenceViewController alloc] init] ;
    configuration = [[Configuration alloc] init] ;

    controller.configuration = configuration  ;
  }) ;
  
  describe(@"init", ^{
    it(@"has a configuration", ^{
      expect(controller.configuration).to.beIdenticalTo(configuration) ;
    }) ;
  }) ;

  describe(@"controllerForConfiguration", ^{
    
    it(@"creates a controller", ^{
      id created = [ConfigurationPreferenceViewController controllerForConfiguration: configuration] ;

      expect(created).to.beKindOf([ConfigurationPreferenceViewController class]) ;
    }) ;

    it(@"links it with the configuration", ^{
      id created = [ConfigurationPreferenceViewController controllerForConfiguration: configuration] ;

      expect([created configuration]).to.beIdenticalTo(configuration) ;
    }) ;
  }) ;
}) ;
SpecEnd