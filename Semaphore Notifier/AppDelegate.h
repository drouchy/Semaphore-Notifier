//
//  AppDelegate.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Configuration.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSMenu *statusMenu;
@property (strong, nonatomic) NSStatusItem *statusItem ;

@property (nonatomic, retain) NSWindowController *preferencesController ;

@property (strong, nonatomic) Configuration *configuration ;
@end
