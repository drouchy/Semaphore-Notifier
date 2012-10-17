//
//  AppDelegate.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize statusItem = _statusItem ;

- (void)dealloc {
  [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
}

- (void) awakeFromNib {
  self.statusItem = [self createStatusItem] ;
}

- (NSStatusItem *) createStatusItem {
  NSStatusItem *statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSVariableStatusItemLength] ;
  statusItem.highlightMode = YES ;
  statusItem.title = @"CI" ;
  statusItem.image = [NSImage imageNamed: @"statusIconTemplate"] ;
  statusItem.menu = self.statusMenu ;
  
  return statusItem ;
}
@end
