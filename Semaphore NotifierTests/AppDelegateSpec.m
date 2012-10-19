//
//  AppDelegateSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "AppDelegate.h"
#import "SpecHelper.h"

SpecBegin(AppDelegateSpec)

describe(@"AppDelegate", ^{
  __block AppDelegate *delegate ;
  
  beforeEach(^{
    delegate = [[AppDelegate alloc] init] ;
  }) ;

  describe(@"properties", ^{
    beforeEach(^{
    }) ;

    pending(@"has a default configuration", ^{
    }) ;

    pending(@"has a configuration", ^{
    }) ;
  }) ;

});
SpecEnd