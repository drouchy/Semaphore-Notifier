//
//  ProjectMenuItemViewController.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Project.h"

@interface ProjectMenuItemViewController : NSViewController

@property (strong, nonatomic) Project *project ;
@property (weak) IBOutlet NSProgressIndicator *loadingIndicator;

+ (id) controllerWithProject: (Project *) aProject ;

- (void) showIndicator ;
- (NSMenuItem *) buildMenuItem ;
@end
