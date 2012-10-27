//
//  BranchMenuItemViewController.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Branch.h"
#import "ResourceMenuItemViewController.h"

@interface BranchMenuItemViewController : ResourceMenuItemViewController

@property (weak) IBOutlet NSImageView *branchStatusImage;

+ (id) controllerWithBranch: (Branch *) aBranch ;

- (Branch *) branch ;

@end