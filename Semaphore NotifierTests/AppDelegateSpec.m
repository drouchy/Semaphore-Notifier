//
//  AppDelegateSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "AppDelegate.h"
#import "SpecHelper.h"
#import "Configuration.h"

SpecBegin(AppDelegateSpec)

describe(@"AppDelegate", ^{
  __block AppDelegate *delegate ;
  
  beforeEach(^{
    delegate = [[AppDelegate alloc] init] ;
  }) ;

  describe(@"properties", ^{
    beforeEach(^{
    }) ;

    it(@"has a default configuration", ^{
      expect(delegate.configuration).toNot.beNil() ;
    }) ;

    it(@"has a configuration", ^{
      Configuration *configuration = [[Configuration alloc] init] ;
      delegate.configuration = configuration ;

      expect(delegate.configuration).to.equal(configuration) ;
    }) ;
  }) ;

});
SpecEnd