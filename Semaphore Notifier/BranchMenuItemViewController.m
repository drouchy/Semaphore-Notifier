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
  BranchMenuItemViewController *controller = [[BranchMenuItemViewController alloc] init] ;
  controller.branch = aBranch ;
  return controller ;
}
- (id)init {
  self = [super initWithNibName:@"BranchMenuItemView" bundle:[NSBundle bundleForClass: [self class]]];
  if (self) {
      // Initialization code here.
  }
  
  return self;
}

- (NSMenuItem *) buildMenuItem {
  NSMenuItem *menuItem = [[NSMenuItem alloc] init] ;
  menuItem.view = self.view ;
  return menuItem ;
}
@end
