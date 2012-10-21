//
//  BranchMenuItemViewController.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Branch.h"
#import "MenuItemViewController.h"

@interface BranchMenuItemViewController : MenuItemViewController

@property (assign) IBOutlet NSProgressIndicator *progressIndicator;
@property (assign) IBOutlet NSImageView *branchStatusImage;

@property (retain, nonatomic) Branch * branch ;

+ (id) controllerWithBranch: (Branch *) aBranch ;
@end