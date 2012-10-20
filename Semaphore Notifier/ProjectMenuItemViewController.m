//
//  ProjectMenuItemViewController.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "ProjectMenuItemViewController.h"

@interface ProjectMenuItemViewController ()
@property (nonatomic) Boolean loading ;
@end

@implementation ProjectMenuItemViewController

@synthesize loading = _loading ;

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

- (void) queryProjectBranches {
  NSLog(@"Requesting the branches of project %@", self.project.name) ;
  NSURL *url = [self.project branchListUrl] ;
  NSLog(@"opening url %@", url) ;
}

- (void) showIndicator {
  if(self.loading) {
    [self.loadingIndicator performSelector:@selector(startAnimation:)
                                withObject:self
                                afterDelay:0.0
                                   inModes:[NSArray
                           arrayWithObject:NSEventTrackingRunLoopMode]];
  }
}

@end