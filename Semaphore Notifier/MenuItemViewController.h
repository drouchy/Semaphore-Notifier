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

@property (assign) IBOutlet NSProgressIndicator *loadingIndicator;
@property (retain, nonatomic) NSNumber *status ;
@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain, nonatomic) NSMenuItem *menuItem;

- (NSMenuItem *) buildMenuItem ;

- (void) parseJson: (NSArray *) json ;
@end
