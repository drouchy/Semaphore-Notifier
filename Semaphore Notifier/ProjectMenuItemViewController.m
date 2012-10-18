//
//  ProjectMenuItemViewController.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "ProjectMenuItemViewController.h"

@interface ProjectMenuItemViewController ()

@end

@implementation ProjectMenuItemViewController

- (id)init {
  self = [super initWithNibName:@"ProjectMenuItemView" bundle: [NSBundle bundleForClass: [self class]]];
  if (self) {
      // Initialization code here.
  }
  
  return self;
}

- (void) awakeFromNib {
  [self showIndicator] ;
}

- (void) showIndicator {
  [self.loadingIndicator performSelector:@selector(startAnimation:)
                              withObject:self
                              afterDelay:0.0
                                 inModes:[NSArray
                         arrayWithObject:NSEventTrackingRunLoopMode]];
}

@end