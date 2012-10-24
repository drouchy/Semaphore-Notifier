//
//  BranchMenuItemViewController.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Branch.h"

@interface BranchMenuItemViewController : NSViewController

@property (weak) IBOutlet NSProgressIndicator *progressIndicator;
@property (weak) IBOutlet NSImageView *branchStatusImage;

@property (strong, nonatomic) Branch * branch ;

+ (id) controllerWithBranch: (Branch *) aBranch ;

- (NSMenuItem *) buildMenuItem ;
@end