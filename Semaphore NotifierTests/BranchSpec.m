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
    }) ;
    
    it(@"has a name", ^{
      expect(branch.name).to.equal(@"branch name") ;
    }) ;
  }) ;
}) ;

SpecEnd