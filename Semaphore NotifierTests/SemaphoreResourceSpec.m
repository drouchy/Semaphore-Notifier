//
//  SemaphoreResourceSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 20/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "SemaphoreResource.h"
#import "SpecHelper.h"
#import "UserDefaultsProvider.h"
#import "Project.h"

SpecBegin(SemaphoreResourceSpec)

describe(@"SemaphoreResource", ^{
  __block SemaphoreResource *resource ;
  __block UserDefaultsProvider *provider ;
  
  describe(@"authToken", ^{
    beforeEach(^{
      provider = [UserDefaultsProvider providerWithSettings: @{ @"authKey": @"my very own key"}] ;
      [SemaphoreResource registerUserDefaultsProvider: provider] ;
      resource = [[SemaphoreResource alloc] init] ;
    }) ;

    it(@"reads the auth token from the user defaults", ^{
      expect([resource authToken]).to.equal(@"my very own key") ;
    }) ;
  }) ;

  describe(@"Semaphore Resources URL", ^{
    beforeEach(^{
      provider = [UserDefaultsProvider providerWithSettings: @{ @"authKey": @"key1"}] ;
      [SemaphoreResource registerUserDefaultsProvider: provider] ;
      resource = [[SemaphoreResource alloc] init] ;
    }) ;
    
    describe(@"Project.branchListUrl", ^{
      __weak Project *project ;

      beforeEach(^{
        project = [Project projectWithName:@"project name" andKey: @"projectkey"] ;
      }) ;
      
      it(@"generates the url", ^{
        expect([[project branchListUrl] absoluteString]).to.equal(@"https://semaphoreapp.com/api/v1/projects/projectkey/branches?auth_token=key1") ;
      }) ;
    }) ;
  
  }) ;
}) ;
SpecEnd