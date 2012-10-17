//
//  ProjectSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "SpecHelper.h"
#import "Project.h"

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
}) ;

SpecEnd