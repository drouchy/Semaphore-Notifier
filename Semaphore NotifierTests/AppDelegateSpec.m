//
//  AppDelegateSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "AppDelegate.h"
#import "SpecHelper.h"
#import "Project.h"
#import "UserDefaultsProvider.h"

@interface AppDelegate()

@property (retain, nonatomic) NSArray *projects ;

- (void) loadProjectMenuItems ;
@end

SpecBegin(AppDelegateSpec)

describe(@"AppDelegate", ^{
  __block AppDelegate *delegate ;
  __block  NSDictionary *settings ;
  
  __block UserDefaultsProvider *provider ;
  
  beforeEach(^{
    settings =  @{ @"projects": @[
                          @{@"name": @"project 1", @"enabled": @YES, @"apiKey": @"key 1"},
                          @{@"name": @"project 2", @"enabled": @NO, @"apiKey": @"key 2"},
                          @{@"name": @"project 3", @"enabled": @YES, @"apiKey": @"key 3"} ]} ;
    
    provider = [UserDefaultsProvider providerWithSettings: settings] ;
    [AppDelegate registerUserDefaultsProvider: provider] ;
    delegate = [[AppDelegate alloc] init] ;
  }) ;
  
  describe(@"init", ^{
    __block NSArray *projects ;
    
    beforeEach(^{
      projects = delegate.projects ;
    }) ;
    
    it(@"builds the projects from the user defautls", ^{
      expect([projects count]).to.equal(3) ;
      NSLog(@"%@", projects) ;
    }) ;
    
    it(@"sets the project name from the user defautls", ^{
      expect([projects[0] name]).to.equal(@"project 1") ;;
    }) ;
    
    it(@"sets the project enabled from the user defautls", ^{
      expect([projects[1] enabled]).to.beFalsy() ;
    }) ;
    
    it(@"sets the project api key from the user defautls", ^{
      expect([projects[0] apiKey]).to.equal(@"key 1") ;
    }) ;
  }) ;

  describe(@"loadProjectMenuItems", ^{
    __block NSMenu *menu ;
    
    beforeEach(^{
      NSApplication *application = [NSApplication sharedApplication];
      [NSBundle loadNibNamed:@"MainMenu" owner:application];
      delegate = [application delegate] ;

      [delegate loadProjectMenuItems] ;
      menu = delegate.statusMenu ;
    }) ;

    it(@"creates an entry for every enabled projects", ^{
      expect([menu.itemArray count]).to.equal(8) ;
    }) ;
  }) ;
});
SpecEnd