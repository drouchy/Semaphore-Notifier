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
  __block Build *build ;
  __block NSDate *startDate = [NSDate dateWithString:@"2012-03-24 10:45:32 +0600"] ;
  __block NSDate *endDate = [NSDate dateWithString:@"2012-03-24 10:55:32 +0600"] ;

  describe(@"init", ^{
    beforeEach(^{
      build = [[Build alloc] init] ;
      build.number = @1 ;
      build.url = [NSURL URLWithString: @"http://host/build"];
      build.startedAt = startDate;
      build.finishedAt = endDate;
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
      expect(build.status).to.equal(BuildStatusNone) ;
    }) ;
  }) ;

  describe(@"updateFromJson", ^{
    __block NSMutableDictionary *json ;
    __block NSDateFormatter* dateFormatter ;

    beforeEach(^{
      json = [@{ @"branch_name": @"master", @"branch_url": @"https://semaphoreapp.com/projects/12/branches/5",
                @"branch_status_url": @"https://semaphoreapp.com/api/v1/projects/23/5682/status?auth_token=12",
                @"branch_history_url": @"https://semaphoreapp.com/api/v1/projects/212/3?auth_token=12",
                @"build_url": @"https://semaphoreapp.com/projects/297/branches/3/builds/8",
                @"build_number": @"8", @"result": @"success",
                @"started_at": @"2012-03-24T04:45:32Z", @"finished_at": @"2012-03-24T04:55:32Z",
                @"commit": @{
                  @"id": @"123a", @"url": @"https://github.com/shutl/quote_service/commit/123a",
                  @"author_name": @"The Author", @"author_email": @"test@example.com",
                  @"message" : @"merge branch test to master" , @"timestamp" : @"2012-10-24T16:18:07Z"
                }
              } mutableCopy];

      build = [[Build alloc] init] ;
      [build updateFromJson: json] ;

      dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    }) ;

    it(@"parses the number", ^{
      expect(build.number).to.equal(8) ;
    }) ;

    it(@"parses the url", ^{
      expect([build.url absoluteString]).to.equal(@"https://semaphoreapp.com/projects/297/branches/3/builds/8") ;
    }) ;

    it(@"parses the startedAt", ^{
      expect(build.startedAt).to.equal(startDate) ;
    }) ;

    it(@"parses the finishedAt", ^{
      expect(build.finishedAt).to.equal(endDate) ;
    }) ;

    describe(@"status", ^{
      it(@"parses the success", ^{
        expect(build.status).to.equal(BuildStatusSuccess) ;
      }) ;
      it(@"parses the failure", ^{
        json[@"result"] = @"failure" ;
        [build updateFromJson: json] ;

        expect(build.status).to.equal(BuildStatusFailure) ;
      }) ;

      it(@"parses the pending", ^{
        json[@"result"] = @"pending" ;
        [build updateFromJson: json] ;

        expect(build.status).to.equal(BuildStatusPending) ;
      }) ;

      it(@"parses an unknown", ^{
        json[@"result"] = @"foo" ;
        [build updateFromJson: json] ;

        expect(build.status).to.equal(BuildStatusUnknown) ;
      }) ;
    }) ;
  }) ;
}) ;

SpecEnd