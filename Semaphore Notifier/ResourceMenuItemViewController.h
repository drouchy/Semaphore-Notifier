//
//  ResourceMenuItemViewController.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 26/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SemaphoreResource.h"

@interface ResourceMenuItemViewController : NSViewController

@property (nonatomic) SemaphoreResource *resource ;

- (id) initWithResource: (SemaphoreResource *) aResource ;

@end
