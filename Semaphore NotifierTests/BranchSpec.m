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
      branch.branchId = @3 ;
      branch.url = [NSURL URLWithString: @"http://host/branch"];
      branch.statusUrl = [NSURL URLWithString: @"http://host/status"];
      branch.historyUrl = [NSURL URLWithString: @"http://host/history"];
    }) ;

    it(@"has a id", ^{
      expect(branch.branchId).to.equal(3) ;
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

    it(@"has no builds", ^{
      expect(branch.builds).to.beEmpty() ;
    }) ;
  }) ;

  describe(@"parseJson", ^{
    __block NSDictionary *json ;

    beforeEach(^{
      json = @{ @"branch_name": @"master", @"branch_url": @"https://semaphoreapp.com/projects/12/branches/5",
                @"branch_status_url": @"https://semaphoreapp.com/api/v1/projects/23/5682/status?auth_token=12",
                @"branch_history_url": @"https://semaphoreapp.com/api/v1/projects/212/3?auth_token=12",
                @"build_url": @"https://semaphoreapp.com/projects/297/branches/3/builds/8",
                @"build_number": @"8", @"result": @"success",
                @"started_at": @"2012-10-24T16:18:24Z", @"finished_at": @"2012-10-24T16:19:32Z",
                @"commit": @{
                      @"id": @"123a", @"url": @"https://github.com/shutl/quote_service/commit/123a",
                      @"author_name": @"The Author", @"author_email": @"test@example.com",
                      @"message" : @"merge branch test to master" , @"timestamp" : @"2012-10-24T16:18:07Z" 
                    }
      };

      branch = [[Branch alloc] init] ;
      [branch updateFromJson: json] ;
    }) ;

    it(@"parses the branch url", ^{
      expect(branch.url).to.equal(@"https://semaphoreapp.com/projects/12/branches/5") ;
    }) ;

    it(@"parses the status url", ^{
      expect(branch.statusUrl).to.equal(@"https://semaphoreapp.com/api/v1/projects/23/5682/status?auth_token=12") ;
    }) ;

    it(@"parses the history url", ^{
      expect(branch.historyUrl).to.equal(@"https://semaphoreapp.com/api/v1/projects/212/3?auth_token=12") ;
    }) ;
  }) ;
}) ;
SpecEnd