//
//  BuildStatusNotifierSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 04/11/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "BuildStatusNotifier.h"
#import "SpecHelper.h"
#import "Branch.h"

SpecBegin(BuildStatusNotifierSpec)

describe(@"BuildStatusNotifier", ^{
  __block id notifier ;

  beforeEach(^{
    notifier = [OCMockObject niceMockForClass:[BuildStatusNotifier class]] ;
  }) ;
}) ;
SpecEnd