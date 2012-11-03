//
//  ProjectSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "SpecHelper.h"
#import "Project.h"
#import "Branch.h"

SpecBegin(ProjectSpec)

describe(@"project", ^{
  __block Project *project ;

  describe(@"init", ^{
    beforeEach(^{
      project = [[Project alloc] init] ;
      project.name = @"project name" ;
      project.apiKey = @"project key" ;
    }) ;

    it(@"has a name", ^{
      expect(project.name).to.equal(@"project name") ;
    }) ;

    it(@"has a api key", ^{
      expect(project.apiKey).to.equal(@"project key") ;
    }) ;

    it(@"has a default name", ^{
      project = [[Project alloc] init] ;

      expect(project.name).to.equal(@"Set the project name") ;
    }) ;

    it(@"has a default apiKey", ^{
      project = [[Project alloc] init] ;

      expect(project.apiKey).to.equal(@"Set the project API key") ;
    }) ;

    it(@"is enable by default", ^{
      expect(project.enabled).to.beTruthy() ;
    }) ;

    it(@"can be disbled", ^{
      project.enabled = NO ;

      expect(project.enabled).to.beFalsy() ;
    }) ;

    it(@"does not have any branches", ^{
      expect(project.branches).to.beEmpty() ;
    }) ;
  }) ;

  describe(@"projectWithName:andKey:", ^{
    beforeEach(^{
      project = [Project projectWithName:@"project name" andKey: @"project key"] ;
    }) ;

    it(@"creates a project", ^{
      expect(project).to.beKindOf([Project class]) ;
    }) ;

    it(@"sets the name", ^{
      expect(project.name).to.equal(@"project name") ;
    }) ;
    
    it(@"set the api key", ^{
      expect(project.apiKey).to.equal(@"project key") ;
    }) ;
  }) ;

  describe(@"parseJson", ^{
    __block NSArray *json  ;
    __block Branch *oneBranch ;
    
    beforeEach(^{
      json = @[ @{@"id": @2, @"name": @"branch 1"}, @{@"id": @3, @"name": @"branch 2"}] ;
      
      [project parseJson: json] ;
      oneBranch = project.branches[0] ;
    }) ;

    it(@"add the branches to the array", ^{
      expect([project.branches count]).to.equal(2) ;
    }) ;

    it(@"parse the id", ^{
      expect(oneBranch.branchId).to.equal(2) ;
    }) ;

    it(@"parse the name", ^{
      expect(oneBranch.name).to.equal(@"branch 1") ;
    }) ;
  }) ;

  describe(@"requestUrl", ^{
    beforeEach(^{
      project.apiKey = @"123" ;
      UserDefaultsProvider *provider = [UserDefaultsProvider providerWithSettings: @{ @"authKey": @"aaa"}] ;
      [SemaphoreResource registerUserDefaultsProvider: provider] ;
    }) ;

    it(@"computes the url based on the authKey & apiKey", ^{
      NSURL *url = [project requestUrl] ;

      expect(url.absoluteString).to.equal(@"https://semaphoreapp.com/api/v1/projects/123/branches?auth_token=aaa") ;
    }) ;
  }) ;
}) ;

SpecEnd