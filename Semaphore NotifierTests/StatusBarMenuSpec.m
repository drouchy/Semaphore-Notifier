//
//  StatusBarMenuSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "SpecHelper.h"
#import "AppDelegate.h"
#import "MASPreferencesWindowController.h"
#import "ConfigurationPreferencesViewController.h"
#import "ProjectsPreferencesViewController.h"
#import "AdvancedPreferencesViewController.h"

@interface AppDelegate()
- (void) launchPreferences:(id) sender ;
@end

SpecBegin(AppDelegateStatusMenuSpec)

describe(@"AppDelegate", ^{
  __weak AppDelegate *delegate ;
  __block NSApplication *application;
  
  beforeEach(^{
    application = [NSApplication sharedApplication];
    [NSBundle loadNibNamed:@"MainMenu" owner:application];
    delegate = [application delegate] ;
  }) ;

  afterEach(^{
    [[NSStatusBar systemStatusBar] removeStatusItem:delegate.statusItem] ;
  }) ;

  describe(@"statusMenu", ^{
    __block NSMenu *statusMenu ;
    
    beforeEach(^{
      [delegate applicationDidFinishLaunching: nil] ;
      statusMenu = delegate.statusItem.menu ;
    }) ;
  }) ;

  describe(@"launchPreferences", ^{
    beforeEach(^{
      [delegate launchPreferences:nil] ;
    }) ;

    it(@"launches a preferences window", ^{
      expect(delegate.preferencesController).toNot.beNil() ;
    }) ;

    // can't get why I've got errors
    // expected: a kind of MASPreferencesWindowController,
    // got: an instance of MASPreferencesWindowController, which is not a kind of MASPreferencesWindowController
    pending(@"creates a MASPreferencesWindowController", ^{
      expect(delegate.preferencesController).to.beKindOf([MASPreferencesWindowController class]) ;
    }) ;

    // Same thing here
    pending(@"creates a preference window with e configuration view controller", ^{
      id viewController = ((MASPreferencesWindowController *) delegate.preferencesController).viewControllers ;

      expect(viewController[0]).to.beKindOf([ConfigurationPreferencesViewController class]) ;
    }) ;

    // Same thing here
    pending(@"creates a preference window with e configuration view controller", ^{
      id viewController = ((MASPreferencesWindowController *) delegate.preferencesController).viewControllers ;
      
      expect(viewController[1]).to.beKindOf([ProjectsPreferencesViewController class]) ;
    }) ;

    // Same thing here
    pending(@"creates a preference window with e configuration view controller", ^{
      id viewController = ((MASPreferencesWindowController *) delegate.preferencesController).viewControllers ;
      
      expect(viewController[2]).to.beKindOf([AdvancedPreferencesViewController class]) ;
    }) ;

    it(@"does not re-create the controller, it memoizes it", ^{
      id viewController = delegate.preferencesController ;
      
      [delegate launchPreferences:nil] ;

      expect(delegate.preferencesController).to.beIdenticalTo(viewController) ;
    }) ;
  }) ;
});
SpecEnd
