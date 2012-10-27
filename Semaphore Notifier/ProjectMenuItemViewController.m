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
@property (strong, nonatomic) NSMenuItem *menuItem;
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

- (NSMenuItem *) buildMenuItem {
  _menuItem = [[NSMenuItem alloc] init] ;
  _menuItem.view = self.view ;
  _menuItem.submenu = [[NSMenu alloc] init] ;
  return _menuItem ;
}

// Check how to test that
- (void) queryProjectBranches {
  NSLog(@"Requesting the branches of project %@", self.project.name) ;
  __block SemaphoreHttpRequestExecutor *request = [SemaphoreHttpRequestExecutor requestForResource: self.resource] ;
  [request execute: ^{ [self loadBranches] ; } ] ;
}

- (void) showIndicator {
  if(self.project.status == ResourceStatusPending) {
    NSLog(@"show indicator") ;
    [self.loadingIndicator performSelector:@selector(startAnimation:)
                                withObject:self
                                afterDelay:0.0
                                   inModes:[NSArray
                           arrayWithObject:NSEventTrackingRunLoopMode]];
    
  } else {
    NSLog(@"stopping animation") ;
    [self.loadingIndicator stopAnimation:nil] ;
  }
}

- (void) loadBranches {
  for(Branch *branch in self.project.branches) {
    NSLog(@"Loading branch: %@ (%@)", branch.name, self.project.name) ;
    BranchMenuItemViewController *controller = [BranchMenuItemViewController controllerWithBranch: branch] ;
    [_menuItem.submenu addItem: [controller buildMenuItem] ] ;
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {

  NSLog(@"<-- observeValueForKeyPath --> %@", keyPath) ;
  if ([keyPath isEqual:@"status"]) {
    [self showIndicator] ;
  }
}
@end