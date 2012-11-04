//
//  BranchSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "Branch.h"
#import "SpecHelper.h"
#import "Build.h"
#import "Project.h"

SpecBegin(BranchSpec)

describe(@"Branch", ^{
  __block Branch *branch ;
  __block id project ;
  
  describe(@"branchOfProject:withName", ^{
    beforeEach(^{
      project = [OCMockObject niceMockForClass: [NSString class]] ;

      branch = [Branch branchOfProject: project withName: @"branch name"] ;
    }) ;

    it(@"links to the project", ^{
      expect(branch.project).to.beIdenticalTo(project) ;
    }) ;

    it(@"sets the name", ^{
      expect(branch.name).to.equal(@"branch name") ;
    }) ;
  }) ;

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

    it(@"has no builds", ^{
      expect(branch.builds).to.beEmpty() ;
    }) ;
  }) ;

  describe(@"updateFromJson", ^{
    __block NSMutableDictionary *json ;

    beforeEach(^{
      json = [ @{ @"branch_name": @"master", @"branch_url": @"https://semaphoreapp.com/projects/12/branches/5",
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
      } mutableCopy];

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

    describe(@"parsing the build", ^{
      it(@"adds the build", ^{
        expect([branch.builds count]).to.equal(1) ;
      }) ;
      
      it(@"parses the build based on the json parameters", ^{
        Build *build = branch.builds[0] ;
        
        expect([build.url absoluteString]).to.equal(@"https://semaphoreapp.com/projects/297/branches/3/builds/8") ;
      }) ;

      it(@"adds an other build", ^{
        json[@"build_number"] = @"9" ;

        [branch updateFromJson: json] ;

        expect([branch.builds count]).to.equal(2) ;
      }) ;

      it(@"adds the last build at the first index", ^{
        json[@"build_number"] = @"9" ;
        
        [branch updateFromJson: json] ;

        Build *build = branch.builds[0] ;
        expect(build.number).to.equal(9) ;
      }) ;

      it(@"keeps only the last 2 builds", ^{
        json[@"build_number"] = @"9" ;
        [branch updateFromJson: json] ;
        json[@"build_number"] = @"10" ;
        [branch updateFromJson: json] ;
        
        expect([branch.builds count]).to.equal(2) ;
      }) ;

      it(@"does not add the build if it is already there", ^{
        [branch updateFromJson: json] ;

        expect([branch.builds count]).to.equal(1) ;
      }) ;
    }) ;
  }) ;

  describe(@"requestUrl", ^{
    __block Project *project ;

    beforeEach(^{
      project = [[Project alloc] init] ;
      branch.project = project ;
      [branch.project setApiKey: @"123"] ;
      branch.branchId = [NSNumber numberWithInt: 132] ;
      
      UserDefaultsProvider *provider = [UserDefaultsProvider providerWithSettings: @{ @"authKey": @"aaa"}] ;
      [SemaphoreResource registerUserDefaultsProvider: provider] ;
    }) ;

    it(@"generates an URL based on the project & the branch", ^{
      NSString *url = [[branch requestUrl] absoluteString] ;

      expect(url).to.equal(@"https://semaphoreapp.com/api/v1/projects/123/132/status?auth_token=aaa") ;
    }) ;
  }) ;

  describe(@"addBuild", ^{
    beforeEach(^{
      branch = [[Branch alloc] init] ;
      branch.status = ResourceStatusFailure ;
    }) ;

    it(@"adds a first build", ^{
      Build *build = [[Build alloc] init] ;
      build.number = [NSNumber numberWithInt: 1] ;

      [branch addBuild: build] ;
      
      expect(branch.builds).to.equal(@[build]) ;
    }) ;

    it(@"does not add an already added build", ^{
      Build *build = [[Build alloc] init] ;
      build.number = [NSNumber numberWithInt: 1] ;
  
      [branch addBuild: build] ;

      build = [[Build alloc] init] ;
      build.number = [NSNumber numberWithInt: 1] ;

      [branch addBuild: build] ;

      expect([branch.builds count]).to.equal(1) ;
    }) ;

    it(@"adds a second build", ^{
      for(int i = 0 ; i < 2 ; i++) {
        Build *build = [[Build alloc] init] ;
        build.number = [NSNumber numberWithInt: i] ;

        [branch addBuild: build] ;

      }

      expect([branch.builds count]).to.equal(2) ;
    }) ;

    it(@"keeps only the last two builds", ^{
      for(int i = 0 ; i < 5 ; i++) {
        Build *build = [[Build alloc] init] ;
        build.number = [NSNumber numberWithInt: i] ;
        
        [branch addBuild: build] ;
        
      }
      
      expect([branch.builds[0] number]).to.equal(4) ;
      expect([branch.builds[1] number]).to.equal(3) ;

    }) ;

    it(@"updates the status of the last build if it was pending", ^{
      Build *build = [[Build alloc] init] ;
      build.number = [NSNumber numberWithInt: 1] ;
      build.status = ResourceStatusPending ;
  
      [branch addBuild: build] ;
      
      build = [[Build alloc] init] ;
      build.number = [NSNumber numberWithInt: 1] ;
      build.status = ResourceStatusSuccess ;

      [branch addBuild: build] ;

      build = branch.builds[0] ;
      expect(build.status).to.equal(ResourceStatusSuccess) ;
    }) ;

    it(@"updates the status of the last build if it was in error", ^{
      Build *build = [[Build alloc] init] ;
      build.number = [NSNumber numberWithInt: 1] ;
      build.status = ResourceStatusError ;
      
      [branch addBuild: build] ;
      
      build = [[Build alloc] init] ;
      build.number = [NSNumber numberWithInt: 1] ;
      build.status = ResourceStatusSuccess ;
      
      [branch addBuild: build] ;
      
      build = branch.builds[0] ;
      expect(build.status).to.equal(ResourceStatusSuccess) ;
    }) ;
  }) ;

  describe(@"status", ^{
    beforeEach(^{
      branch = [[Branch alloc] init] ;
      branch.status = ResourceStatusFailure ;
    }) ;

    it(@"returns the status of the resource when no build", ^{
      expect([branch status]).to.equal(ResourceStatusFailure) ;
    }) ;

    it(@"returns the last build status", ^{
      Build *build = [[Build alloc] init] ;
      build.number = [NSNumber numberWithInt: 1] ;
      build.status = ResourceStatusLoading ;
      [branch addBuild: build] ;

      expect(branch.status).to.equal(ResourceStatusLoading) ;
    }) ;
  }) ;
}) ;
SpecEnd