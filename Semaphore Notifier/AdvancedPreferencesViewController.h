//
//  AdvancedPreferencesViewController.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MASPreferencesViewController.h"
#import "Configuration.h"

@interface AdvancedPreferencesViewController : NSViewController <MASPreferencesViewController>

@property (retain) Configuration *configuration ;

+ (id) controllerForConfiguration: (Configuration *) aConfiguration ;
@end
