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
#import "Constants.h"

@interface BranchMenuItemViewController : MenuItemViewController

@property (weak) IBOutlet NSImageView *branchStatusImage;

@property (nonatomic) Branch * branch ;
@property (nonatomic) NSImage *lastBuildImage ;

+ (id) controllerWithBranch: (Branch *) aBranch ;
- (void) queryBranchStatus ;
@end