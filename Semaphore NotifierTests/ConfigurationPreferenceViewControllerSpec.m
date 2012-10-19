//
//  ConfigurationPreferenceViewControllerSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "SpecHelper.h"
#import "ConfigurationPreferencesViewController.h"
#import "PreferencesViewControllerSharedExamples.h"

@interface ConfigurationPreferencesViewController()
- (NSString *) identifier ;
- (NSImage *)  toolbarItemImage ;
- (NSString *) toolbarItemLabel ;
@end

SpecBegin(ConfigurationPreferenceViewControllerSpec)

describe(@"ConfigurationPreferenceViewController", ^{
  __block ConfigurationPreferencesViewController *controller ;
  
  beforeEach(^{
    controller = [[ConfigurationPreferencesViewController alloc] init] ;
  }) ;

  itBehavesLike(@"a preferences view controller", @{ @"controllerClass": [ConfigurationPreferencesViewController class]}) ;

  itBehavesLike(@"a MASPreferences controller", @{
                      @"controllerClass": [ConfigurationPreferencesViewController class],
                      @"identifier": @"GeneralPreferences",
                      @"toolbarItemImage": @"NSPreferencesGeneral",
                      @"toolbarItemLabel": @"General"
                    }) ;
}) ;
SpecEnd