//
//  ProjectMenuItemViewController.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "ProjectMenuItemViewController.h"
#import "BranchMenuItemViewController.h"

#import "Branch.h"

@interface ProjectMenuItemViewController ()
@property (strong, nonatomic) NSMutableArray *branchesController ;
@end

@implementation ProjectMenuItemViewController

@synthesize branchesController = _branchesController ;

+ (id) controllerWithProject: (Project *) aProject {
  ProjectMenuItemViewController *controller = [[self alloc] init] ;
  controller.project = aProject ;
  return controller ;
}

- (id)init {
  self = [super initWithNibName:@"ProjectMenuItemView" bundle: [NSBundle bundleForClass: [self class]]];
  if (self) {
      // Initialization code here.
  }
  
  return self;
}

- (void) awakeFromNib {
  [self queryProjectBranches] ;
}

// Check how to test that
- (void) queryProjectBranches {
  NSLog(@"Requesting the branches of project %@", self.project.name) ;
  NSURL *url = [self.project branchListUrl] ;
  NSLog(@"opening url %@", url) ;

  NSURLRequest *theRequest = [NSURLRequest requestWithURL: url
                                              cachePolicy: NSURLRequestReloadIgnoringLocalCacheData
                                          timeoutInterval: 10.0];
  self.status = [NSNumber numberWithInt: ResourceStatusLoading] ;
  NSURLConnection *theConnection= [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
  
  if (!theConnection) {
    self.status = [NSNumber numberWithInt: ResourceStatusLoading] ;
    NSLog(@"Error while requesting branches of project %@", self.project.name) ;
  }
}

- (void) parseJson: (id) json {
  NSLog(@"parsing the JSON message: %@", json) ;
  [_project loadBranches: json] ;
  [self loadBranches] ;
}

- (void) loadBranches {
  for(Branch *branch in self.project.branches) {
    NSLog(@"Loading branch: %@ (%@)", branch.name, self.project.name) ;
    BranchMenuItemViewController *controller = [BranchMenuItemViewController controllerWithBranch: branch] ;
    [controller queryBranchStatus] ;
    [self.menuItem.submenu addItem: [controller buildMenuItem: self.menuItem.menu.delegate] ] ;
  }
}
@end