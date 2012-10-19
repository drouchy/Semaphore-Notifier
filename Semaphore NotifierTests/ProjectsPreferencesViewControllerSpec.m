//
//  ProjectsPreferencesViewControllerSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "ProjectsPreferencesViewController.h"
#import "SpecHelper.h"

@interface ProjectsPreferencesViewController()
- (NSString *) identifier ;
- (NSImage *)  toolbarItemImage ;
- (NSString *) toolbarItemLabel ;
@end

SpecBegin(ProjectsPreferencesViewControllerSpec)

describe(@"ProjectsPreferencesViewController", ^{
  __block ProjectsPreferencesViewController *controller ;
  
  beforeEach(^{
    controller = [[ProjectsPreferencesViewController alloc] init] ;
  }) ;
  
  itBehavesLike(@"a preferences view controller", @{ @"controllerClass": [ProjectsPreferencesViewController class]}) ;
  
  itBehavesLike(@"a MASPreferences controller", @{
                      @"controllerClass": [ProjectsPreferencesViewController class],
                      @"identifier": @"ProjectsPreferences",
                      @"toolbarItemImage": @"NSEveryone",
                      @"toolbarItemLabel": @"Projects"
                }) ;

}) ;

SpecEnd