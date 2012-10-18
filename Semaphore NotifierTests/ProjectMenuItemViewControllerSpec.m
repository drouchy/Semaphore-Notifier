//
//  ProjectMenuItemViewControllerSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "ProjectMenuItemViewController.h"
#import "SpecHelper.h"

SpecBegin(ProjectMenuItemViewControllerSpec)

describe(@"ProjectMenuItemViewController", ^{
  __block ProjectMenuItemViewController *controller ;
  __block Project *project ;
  
  beforeEach(^{
    controller = [[ProjectMenuItemViewController alloc] init] ;
    project = [Project projectWithName: @"project name" andKey: @"123a"] ;
  }) ;
  
}) ;

SpecEnd