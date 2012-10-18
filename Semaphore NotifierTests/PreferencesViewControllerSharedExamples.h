//
//  PreferencesViewControllerSharedExamples.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#ifndef Semaphore_Notifier_PreferencesViewControllerSharedExamples_h
#define Semaphore_Notifier_PreferencesViewControllerSharedExamples_h

#import "SpecHelper.h"
#import "Configuration.h"

SharedExampleGroupsBegin(PreferencesViewControllerShared)

sharedExamplesFor(@"a preferences view controller", ^(NSDictionary *data) {
  __block Class controllerClass ;
  
  __block id controller ;
  __block Configuration *configuration ;
  
  beforeEach(^{
    controllerClass = data[@"controllerClass"] ;
    
    controller = [[controllerClass alloc] init] ;
    configuration = [[Configuration alloc] init] ;
    
    [controller performSelector: @selector(setConfiguration:) withObject:configuration ]  ;
  }) ;
  
  describe(@"init", ^{
    it(@"has a configuration", ^{
      expect([controller performSelector: @selector(configuration)]).to.beIdenticalTo(configuration) ;
    }) ;
  }) ;
  
  describe(@"controllerForConfiguration", ^{
    
    it(@"creates a controller", ^{
      id created = [controllerClass performSelector: @selector(controllerForConfiguration:) withObject:configuration] ;
      
      expect(created).to.beKindOf(controllerClass) ;
    }) ;
    
    it(@"links it with the configuration", ^{
      id created = [controllerClass performSelector: @selector(controllerForConfiguration:) withObject:configuration] ;
      
      expect([created performSelector: @selector(configuration)]).to.beIdenticalTo(configuration) ;
    }) ;
  }) ;
  
});

sharedExamplesFor(@"a MASPreferences controller", ^(NSDictionary *data) {
  __block id controller ;
  
  beforeEach(^{
    Class controllerClass = data[@"controllerClass"] ;
    
    controller = [[controllerClass alloc] init] ;
    
    [controller performSelector: @selector(setConfiguration:) withObject:[[Configuration alloc] init] ]  ;
  }) ;
  
  it(@"has a identifier", ^{
    expect([controller identifier]).to.equal(data[@"identifier"]) ;
  }) ;
  
  it(@"has a toolbar item image", ^{
    id item = [controller performSelector:  @selector(toolbarItemImage)] ;

    expect([item name]).to.equal(data[@"toolbarItemImage"]) ;
  }) ;
  
  it(@"has a toolbar item label", ^{
    id item = [controller performSelector: @selector(toolbarItemLabel)] ;

    expect(item).to.equal(data[@"toolbarItemLabel"]) ;
  }) ;
}) ;

SharedExampleGroupsEnd

#endif
