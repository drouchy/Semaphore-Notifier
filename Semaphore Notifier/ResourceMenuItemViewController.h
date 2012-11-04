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

@property (weak) IBOutlet NSProgressIndicator *loadingIndicator;
@property (nonatomic) SemaphoreResource *resource ;
@property (strong, nonatomic) NSMenuItem *menuItem;

- (id) initWithResource: (SemaphoreResource *) aResource ;

- (NSMenuItem *) buildMenuItem ;
- (void) showIndicators ;
- (void) updateResourceStatus: (ResourceStatus) status ;
- (void) refresh ;
@end
