//
//  ProjectMenuItemViewController.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Project.h"
#import "MenuItemViewController.h"

@interface ProjectMenuItemViewController : MenuItemViewController

@property (nonatomic) Project *project ;

+ (id) controllerWithProject: (Project *) aProject ;

@end
