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

SharedExampleGroupsBegin(PreferencesViewControllerShared)

sharedExamplesFor(@"a preferences view controller", ^(NSDictionary *data) {
  __block Class controllerClass ;
  
  __block id controller ;
  
  beforeEach(^{
    controllerClass = data[@"controllerClass"] ;
    
    controller = [[controllerClass alloc] init] ;
  }) ;
  
  describe(@"init", ^{
  }) ;
  
  describe(@"controllerForConfiguration", ^{
    
    it(@"creates a controller", ^{
      id created = [controllerClass performSelector: @selector(controller)] ;
      
      expect(created).to.beKindOf(controllerClass) ;
    }) ;
  }) ;
  
});

sharedExamplesFor(@"a MASPreferences controller", ^(NSDictionary *data) {
  __unsafe_unretained id controller ;
  
  beforeEach(^{
    Class controllerClass = data[@"controllerClass"] ;
    
    controller = [[controllerClass alloc] init] ;
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
