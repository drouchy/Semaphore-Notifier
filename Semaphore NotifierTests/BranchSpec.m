//
//  BranchSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "Branch.h"
#import "SpecHelper.h"

SpecBegin(BranchSpec)

describe(@"Branch", ^{
  __block Branch *branch ;
  
  describe(@"init", ^{
    beforeEach(^{
      branch = [[Branch alloc] init] ;
      branch.name = @"branch name" ;
      branch.url = [NSURL URLWithString: @"http://host/branch"];
      branch.statusUrl = [NSURL URLWithString: @"http://host/status"];
      branch.historyUrl = [NSURL URLWithString: @"http://host/history"];
    }) ;
    
    it(@"has a name", ^{
      expect(branch.name).to.equal(@"branch name") ;
    }) ;

    it(@"has a url", ^{
      expect(branch.url).to.equal([NSURL URLWithString: @"http://host/branch"]) ;
    }) ;

    it(@"has a statusUrl", ^{
      expect(branch.statusUrl).to.equal([NSURL URLWithString: @"http://host/status"]) ;
    }) ;

    it(@"has a name", ^{
      expect(branch.historyUrl).to.equal([NSURL URLWithString: @"http://host/history"]) ;
    }) ;

    it(@"has a uknown last status by default", ^{
      expect([branch lastStatus]).to.equal(BuildStatusNone) ;
    }) ;
  }) ;
}) ;

SpecEnd