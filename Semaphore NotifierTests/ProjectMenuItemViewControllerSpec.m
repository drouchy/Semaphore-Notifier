//
//  ProjectMenuItemViewControllerSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "ProjectMenuItemViewController.h"
#import "SpecHelper.h"
#import "StatusBarMenuItemView.h"

@interface ProjectMenuItemViewController ()
@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain, nonatomic) NSMenuItem *menuItem;
@property (retain, nonatomic) NSMutableArray *branchesController ;

- (void) loadBranches ;
@end

SpecBegin(ProjectMenuItemViewControllerSpec)

describe(@"ProjectMenuItemViewController", ^{
  __block ProjectMenuItemViewController *controller ;
  __block Project *project ;
  
  beforeEach(^{
    controller = [[ProjectMenuItemViewController alloc] init] ;
    project = [Project projectWithName: @"project name" andKey: @"123a"] ;
    controller.resource = project ;
  }) ;

  describe(@"controllerWithProject", ^{
    beforeEach(^{
      controller = [ProjectMenuItemViewController controllerWithProject: project] ;
    }) ;

    it(@"creates a project controller", ^{
      expect(controller).to.beKindOf([ProjectMenuItemViewController class]) ;
    }) ;

    it(@"links it to the project", ^{
      expect(controller.project).to.beIdenticalTo(project) ;
    }) ;
  }) ;

  describe(@"buildMenuItem", ^{
    __block NSMenuItem *item ;

    beforeEach(^{
      item = [controller buildMenuItem] ;
    }) ;

    // Still the issue with the class comparison
    pending(@"creates a menu item with a specific view", ^{
      expect([item view]).to.beKindOf([StatusBarMenuItemView class]) ;
    }) ;

    // can't load the controller view
    pending(@"adds a submenuf for the branch list", ^{
      expect(controller.menuItem.submenu).toNot.beNil() ;
    }) ;
  }) ;

  describe(@"loadBranches", ^{
  
    beforeEach(^{
      NSArray *branches = @[ [[Branch alloc] init], [[Branch alloc] init]] ;
      project.branches = [branches mutableCopy] ;
    }) ;

    // can't load the controller view
    pending(@"adds a submenu item for each branch", ^{
      [controller loadBranches] ;
      expect([[controller.menuItem.submenu itemArray] count]).to.equal(2) ;
    }) ;
  }) ;
}) ;

SpecEnd