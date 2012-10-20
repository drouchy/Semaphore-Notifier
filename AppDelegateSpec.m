//
//  AppDelegateSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "AppDelegate.h"
#import "SpecHelper.h"
#import "ApplicationUserDefaultsMock.h"
#import "Project.h"

@interface AppDelegate()
@property (retain, nonatomic) NSArray *projects ;
@end

SpecBegin(AppDelegateSpec)

describe(@"AppDelegate", ^{
  __block AppDelegate *delegate ;
  __block  NSDictionary *settings =  @{ @"projects": @[
                                            @{@"name": @"project 1", @"enabled": @YES, @"apiKey": @"key 1"},
                                            @{@"name": @"project 2", @"enabled": @NO, @"apiKey": @"key 2"},
                                            @{@"name": @"project 3", @"enabled": @YES, @"apiKey": @"key 3"} ]} ;
  
  __block ApplicationUserDefaultsMock *provider ;
  
  beforeEach(^{
    provider = [ApplicationUserDefaultsMock mockWithDefaults: settings] ;
    [provider mockUserDefaultsForApp] ;
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
      expect([projects[0] enabled]).to.beTruthy() ;
    }) ;

    it(@"sets the project api key from the user defautls", ^{
      expect([projects[0] apiKey]).to.equal(@"key 1") ;
    }) ;
  }) ;
  
  describe(@"properties", ^{
  }) ;
});
SpecEnd