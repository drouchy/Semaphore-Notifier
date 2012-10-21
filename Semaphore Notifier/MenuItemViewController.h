//
//  MenuItemViewController.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 21/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Constants.h"

@interface MenuItemViewController : NSViewController

@property (weak) IBOutlet NSProgressIndicator *loadingIndicator;
@property (strong, nonatomic) NSNumber *status ;
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) NSMenuItem *menuItem;

- (NSMenuItem *) buildMenuItem: (id) delegate ;

- (void) showIndicator ;
- (void) parseJson: (id) json ;
- (void) redrawMenuItem ;
@end
