//
//  AppDelegate.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UserDefaultsProvider.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSMenu *statusMenu;
@property (strong, nonatomic) NSStatusItem *statusItem ;

@property (nonatomic, strong) NSWindowController *preferencesController ;

+ (void) registerUserDefaultsProvider: (UserDefaultsProvider *) provider ;

@end
