//
//  BranchMenuItemViewController.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "BranchMenuItemViewController.h"
#import "Build.h"

@interface BranchMenuItemViewController ()

@end

@implementation BranchMenuItemViewController

+ (id) controllerWithBranch: (Branch *) aBranch {
  BranchMenuItemViewController *controller = [[BranchMenuItemViewController alloc] init] ;
  controller.branch = aBranch ;
  return controller ;
}
- (id)init {
  self = [super initWithNibName:@"BranchMenuItemView" bundle:[NSBundle bundleForClass: [self class]]];
  if (self) {
  }
  
  return self;
}

// Check how to test that
- (void) queryBranchStatus {
  NSLog(@"Requesting the build status of branch %@", self.branch.name) ;
  NSURL *url = [self.branch lastBuildUrl] ;
  NSLog(@"opening url %@", url) ;
  
  NSURLRequest *theRequest = [NSURLRequest requestWithURL: url
                                              cachePolicy: NSURLRequestReloadIgnoringLocalCacheData
                                          timeoutInterval: 10.0];
  self.status = [NSNumber numberWithInt: ResourceStatusLoading] ;
  NSURLConnection *theConnection= [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
  
  if (!theConnection) {
    self.status = [NSNumber numberWithInt: ResourceStatusLoading] ;
    NSLog(@"Error while requesting last build status of branch %@", self.branch.name) ;
  }
  [self redrawMenuItem] ;
}

- (void) parseJson: (id) json {
  [self.branch loadBuild: json] ;
}

- (NSImage *) computeLastBuildImage {
  NSLog(@"--> %@",[self lastBuildImageName]) ;
  return [NSImage imageNamed: [self lastBuildImageName]] ;
}

- (NSString *) lastBuildImageName {
  int status = [self.branch lastStatus] ;
  NSLog(@"Status image for status: %d", status) ;
  if(status == BuildStatusSuccess) {
    return @"statusSuccess" ;
  } else if(status == BuildStatusFailure) {
    return @"statusFailure" ;
  }
  return @"statusUnknown" ;
}

- (void) redrawMenuItem {
  [super redrawMenuItem] ;
  NSLog(@"didChangeValueForKey: lastBuildImage") ;
  self.lastBuildImage = [self computeLastBuildImage] ;
  [self didChangeValueForKey:@"lastBuildImage"] ;
}

- (void) refresh: (id) sender {
  NSLog(@"refreshing branch %@ (%@)", self.branch.name, [self.branch.project name]) ;
  [self queryBranchStatus] ;
}
@end
