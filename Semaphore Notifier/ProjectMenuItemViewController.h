//
//  ProjectMenuItemViewController.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Project.h"
#import "ResourceMenuItemViewController.h"

@interface ProjectMenuItemViewController : ResourceMenuItemViewController

+ (id) controllerWithProject: (Project *) aProject ;

- (Project *) project ;

@end
