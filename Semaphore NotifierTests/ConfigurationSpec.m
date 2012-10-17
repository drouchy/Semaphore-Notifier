//
//  ConfigurationSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//
#import "SpecHelper.h"

SpecBegin(ConfigurationSpec)

describe(@"ConfigurationSpec", ^{
  it(@"checks to expecta configuration", ^{
    expect(YES).to.beTruthy() ;
  }) ;

  it(@"checks OCMock configutation", ^{
    id mock = [OCMockObject mockForClass:[NSString class]] ;
    [[[mock stub] andReturn:@"VALUE"] capitalizedString] ;
    
    expect([mock capitalizedString]).to.equal(@"VALUE") ;
  }) ;
}) ;
SpecEnd