//
//  BranchMenuItemViewController.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "BranchMenuItemViewController.h"
#import "SpecHelper.h"
#import "StatusBarMenuItemView.h"

SpecBegin(BranchMenuItemViewControllerSpec)

describe(@"BranchMenuItemViewController", ^{
  __weak BranchMenuItemViewController *controller ;
  __weak Branch *branch ;
  
  beforeEach(^{
    controller = [[BranchMenuItemViewController alloc] init] ;
    branch = [[Branch alloc] init] ;
    branch.name = @"branch name" ;
  }) ;

  describe(@"controllerWithBranch", ^{
    beforeEach(^{
      controller = [BranchMenuItemViewController controllerWithBranch: branch] ;
    }) ;
    
    it(@"creates a project controller", ^{
      expect(controller).to.beKindOf([BranchMenuItemViewController class]) ;
    }) ;
    
    it(@"links it to the project", ^{
      expect(controller.branch).to.beIdenticalTo(branch) ;
    }) ;
  }) ;

  describe(@"buildMenuItem", ^{
    __weak NSMenuItem *item ;
    
    beforeEach(^{
      //item = [controller buildMenuItem] ;
      [item view] ;
    }) ;

    // Still the issue with the class comparison
    pending(@"creates a menu item with a specific view", ^{
      expect([item view]).to.beKindOf([StatusBarMenuItemView class]) ;
    }) ;
  }) ;
}) ;

SpecEnd