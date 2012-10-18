//
//  ConfigurationPreferenceViewController.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Configuration.h"
#import "MASPreferencesViewController.h"

@interface ConfigurationPreferencesViewController : NSViewController <MASPreferencesViewController>

@property (retain) Configuration *configuration ;

+ (id) controllerForConfiguration: (Configuration *) aConfiguration ;
@end
