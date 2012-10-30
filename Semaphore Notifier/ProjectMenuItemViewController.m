//
//  ProjectMenuItemViewController.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "ProjectMenuItemViewController.h"
#import "BranchMenuItemViewController.h"
#import "SemaphoreHttpRequestExecutor.h"

#import "Branch.h"

@interface ProjectMenuItemViewController ()

@property (strong, nonatomic) NSMutableArray *branchControllers ;

@end

@implementation ProjectMenuItemViewController

+ (id) controllerWithProject: (Project *) aProject {
  ProjectMenuItemViewController *controller = [[self alloc] initWithProject: aProject] ;
  return controller ;
}

- (id)initWithProject: (Project *) aProject {
  self = [super initWithNibName:@"ProjectMenuItemView" bundle: [NSBundle bundleForClass: [self class]]];
  if (self) {
    self.resource = aProject ;
  }
  return self;
}

- (Project *) project {
  return (Project *) self.resource ;
}

- (void) awakeFromNib {
  [super awakeFromNib] ;
  [self.resource addObserver:self
                  forKeyPath:@"status"
                     options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                     context:@"KVO_CONTEXT_STATUS_CHANGED"];

  [self queryProjectBranches] ;
}

// Check how to test that
- (void) queryProjectBranches {
  NSLog(@"Requesting the branches of project %@", self.project.name) ;
  __block SemaphoreHttpRequestExecutor *request = [SemaphoreHttpRequestExecutor requestForResource: self.resource delegate: self] ;
  [request execute: ^{ [self loadBranches] ; } statusBlock: ^(ResourceStatus status){ self.resource.status = status ; }] ;
}

- (void) loadBranches {
  for(Branch *branch in self.project.branches) {
    NSLog(@"Loading branch: %@ (%@)", branch.name, self.project.name) ;
    BranchMenuItemViewController *controller = [BranchMenuItemViewController controllerWithBranch: branch] ;
    [self.menuItem.submenu addItem: [controller buildMenuItem] ] ;
    [self.branchControllers addObject: controller] ;
  }
}

// Don't know how to test that
- (void)menuWillOpen:(NSMenu *)menu {
  NSTimer *timer = [NSTimer timerWithTimeInterval:0 target:self selector:@selector(animateProgress:) userInfo:nil repeats:NO];
  [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSEventTrackingRunLoopMode];
}

- (void)animateProgress:(NSTimer *)timer {
  NSLog(@"animate progress: %@", self.branchControllers) ;
  for(BranchMenuItemViewController *controller in self.branchControllers) {
    [controller showIndicator] ;
  }
}

@end