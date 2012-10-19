//
//  AdvancedPreferencesViewControllerSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "AdvancedPreferencesViewController.h"
#import "SpecHelper.h"

@interface AdvancedPreferencesViewController()
- (NSString *) identifier ;
- (NSImage *)  toolbarItemImage ;
- (NSString *) toolbarItemLabel ;
@end

SpecBegin(AdvancedPreferencesViewControllerSpec)

describe(@"AdvancedPreferencesViewController.h", ^{
  __block AdvancedPreferencesViewController *controller ;
  
  beforeEach(^{
    controller = [[AdvancedPreferencesViewController alloc] init] ;
  }) ;
  
  itBehavesLike(@"a preferences view controller", @{ @"controllerClass": [AdvancedPreferencesViewController class]}) ;
  
  itBehavesLike(@"a MASPreferences controller", @{
                        @"controllerClass": [AdvancedPreferencesViewController class],
                        @"identifier": @"AdvancedPreferences",
                        @"toolbarItemImage": @"NSAdvanced",
                        @"toolbarItemLabel": @"Advanced"
                }) ;
 
}) ;

SpecEnd
