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
@property (strong, nonatomic) NSMutableData *receivedData;
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
  NSURL *url = [self.project branchListUrl] ;
  NSLog(@"opening url %@", url) ;

  NSURLRequest *theRequest = [NSURLRequest requestWithURL: url
                                              cachePolicy: NSURLRequestReloadIgnoringLocalCacheData
                                          timeoutInterval: 10.0];
  self.resource.status = ResourceStatusPending ;
  NSURLConnection *theConnection= [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
  
  if (!theConnection) {
    self.resource.status = ResourceStatusError ;
    NSLog(@"Error while requesting branches of ResourceStatusPending %@", self.project.name) ;
  }
}

- (void) showIndicator {
  if(self.project.status == ResourceStatusPending) {
    [self.loadingIndicator performSelector:@selector(startAnimation:)
                                withObject:self
                                afterDelay:0.0
                                   inModes:[NSArray
                           arrayWithObject:NSEventTrackingRunLoopMode]];
  }
}

#pragma mark NSURLConnection methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  NSLog(@"did receive response (%@)", self.project.name) ;
  _receivedData = [[NSMutableData alloc] init];
  [_receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  NSLog(@"did receive data (%@)", self.project.name) ;
  NSLog(@"%@", _receivedData) ;
  [_receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  NSLog(@"did fail with error (%@)", self.project.name) ;
  self.project.status = ResourceStatusError ;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  NSLog(@"did finish loading (%@)", self.project.name) ;

  NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: _receivedData options: NSJSONReadingMutableContainers error: nil];
  if(jsonArray) {
    NSLog(@"parsing the JSON message: %@", jsonArray) ;
    [self.project loadBranches: jsonArray] ;
    [self loadBranches] ;
    // mark as loaded
  } else {
    self.project.status = ResourceStatusError ;
    NSLog(@"Failed to parse the response (%@)", self.project.name) ;
  }
}

- (void) loadBranches {
  for(Branch *branch in self.project.branches) {
    NSLog(@"Loading branch: %@ (%@)", branch.name, self.project.name) ;
    BranchMenuItemViewController *controller = [BranchMenuItemViewController controllerWithBranch: branch] ;
    [_menuItem.submenu addItem: [controller buildMenuItem] ] ;
  }
}
@end