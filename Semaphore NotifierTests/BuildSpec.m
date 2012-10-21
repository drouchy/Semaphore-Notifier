//
//  BuildSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "Build.h"
#import "SpecHelper.h"

SpecBegin(BuildSpec)

describe(@"Build", ^{
  __weak Build *build ;
  __block NSDate *startDate = [NSDate dateWithString:@"2012-03-24 10:45:32 +0600"] ;
  __block NSDate *endDate = [NSDate dateWithString:@"2012-03-24 10:55:32 +0600"] ;

  describe(@"init", ^{
    beforeEach(^{
      build = [[Build alloc] init] ;
      build.number = @1 ;
      build.url = [NSURL URLWithString: @"http://host/build"];
      build.startedAt = startDate;
      build.finishedAt = endDate;
      build.status = 1 ;
    }) ;
    
    it(@"has a number", ^{
      expect(build.number).to.equal(1) ;
    }) ;

    it(@"has a url", ^{
      expect(build.url).to.equal([NSURL URLWithString: @"http://host/build"]) ;
    }) ;

    it(@"has a startedAt", ^{
      expect(build.startedAt).to.equal(startDate) ;
    }) ;

    it(@"has a finishedAt", ^{
      expect(build.finishedAt).to.equal(endDate) ;
    }) ;

    it(@"has a status", ^{
      expect(build.status).to.equal(1) ;
    }) ;
  }) ;
}) ;

SpecEnd