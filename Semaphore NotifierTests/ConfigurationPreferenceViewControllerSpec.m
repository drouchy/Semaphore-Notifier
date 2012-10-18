//
//  ConfigurationPreferenceViewControllerSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "SpecHelper.h"
#import "ConfigurationPreferencesViewController.h"

@interface ConfigurationPreferencesViewController()
- (NSString *) identifier ;
- (NSImage *)  toolbarItemImage ;
- (NSString *) toolbarItemLabel ;
@end

SpecBegin(ConfigurationPreferenceViewControllerSpec)

describe(@"ConfigurationPreferenceViewController", ^{
  __block ConfigurationPreferencesViewController *controller ;
  __block Configuration *configuration ;
  
  beforeEach(^{
    controller = [[ConfigurationPreferencesViewController alloc] init] ;
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
      id created = [ConfigurationPreferencesViewController controllerForConfiguration: configuration] ;

      expect(created).to.beKindOf([ConfigurationPreferencesViewController class]) ;
    }) ;

    it(@"links it with the configuration", ^{
      id created = [ConfigurationPreferencesViewController controllerForConfiguration: configuration] ;

      expect([created configuration]).to.beIdenticalTo(configuration) ;
    }) ;

    it(@"creates one configuration preferences view controller", ^{}) ;
  }) ;

  describe(@"MASPreferencesViewController protocol", ^{
    it(@"has a identifier", ^{
      expect([controller identifier]).to.equal(@"GeneralPreferences") ;
    }) ;

    it(@"has a toolbar item image", ^{
      expect([controller toolbarItemImage].name).to.equal(@"NSPreferencesGeneral") ;
    }) ;

    it(@"has a toolbar item label", ^{
      expect([controller toolbarItemLabel]).to.equal(@"General") ;
    }) ;
  }) ;
}) ;
SpecEnd