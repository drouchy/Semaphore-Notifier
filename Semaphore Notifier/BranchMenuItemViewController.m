//
//  BranchMenuItemViewController.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "BranchMenuItemViewController.h"

@interface BranchMenuItemViewController ()

@end

@implementation BranchMenuItemViewController

+ (id) controllerWithBranch: (Branch *) aBranch {
  return[[BranchMenuItemViewController alloc] initWithBranch: aBranch] ;
}

- (id) initWithBranch: (Branch *) aBranch {
  self = [super initWithNibName:@"BranchMenuItemView" bundle:[NSBundle bundleForClass: [self class]]];
  if (self) {
      self.resource = aBranch ;
  }
  
  return self;
}

- (Branch *) branch {
  return (Branch *) self.resource ;
}

@end
