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
#import "StatusBarMenuItemView.h"

#import "Branch.h"

@interface ProjectMenuItemViewController ()
@property (strong, nonatomic) NSMutableArray *branchesController ;
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
    self.branchesController = [NSMutableArray array] ;
  }
  
  return self;
}

- (Project *) project {
  return (Project *) self.resource ;
}

- (void) awakeFromNib {
  [self.project addObserver:self
                  forKeyPath:@"status"
                     options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                    context:NULL];  
  [self queryProjectBranches] ;

}

// Check how to test that
- (void) queryProjectBranches {
  NSLog(@"Requesting the branches of project %@", self.project.name) ;
  __block SemaphoreHttpRequestExecutor *request = [SemaphoreHttpRequestExecutor requestForResource: self.resource] ;
  [request execute: ^{
      [self loadBranches] ;
      [self didChangeValueForKey: @"shouldHideTheSubmenuImage"] ;
    }
       statusBlock: ^(ResourceStatus status){ [self updateResourceStatus: status] ; }] ;
}

- (void) loadBranches {
  for(Branch *branch in self.project.branches) {
    NSLog(@"Loading branch: %@ (%@)", branch.name, self.project.name) ;
    BranchMenuItemViewController *controller = [BranchMenuItemViewController controllerWithBranch: branch] ;
    [self.branchesController addObject:controller] ;
    [self.menuItem.submenu addItem: [controller buildMenuItem] ] ;
  }
}

- (Boolean) shouldHideTheSubmenuImage {
  return [[[self project] branches] count] == 0 ;
}

- (void) refresh {
  NSLog(@"Refreshing project %@", self.project.name) ;
  for(BranchMenuItemViewController *controller in self.branchesController) {
    [controller refresh] ;
  }
}

@end