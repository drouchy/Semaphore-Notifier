//
//  ConfigurationSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "Configuration.h"
#import "Spechelper.h"
#import "Project.h"

SpecBegin(ConfigurationSpec)

describe(@"Configuration", ^{
  __block Configuration *configuration ;
  __block NSArray *projects ;

  beforeEach(^{
    configuration = [[Configuration alloc] init] ;
    projects = @[ [Project projectWithName: @"project 1" andKey: @"key1"],
                  [Project projectWithName: @"project 2" andKey: @"key2"] ] ;

    configuration.authKey = @"1234a" ;
    configuration.projects = projects ;
  }) ;

  describe(@"init", ^{
    it(@"has a authentication key", ^{
      expect(configuration.authKey).to.equal(@"1234a") ;
    }) ;
    
    it(@"has some projects", ^{
      expect(configuration.projects).to.equal(projects) ;
    }) ;
  }) ;
}) ;
SpecEnd