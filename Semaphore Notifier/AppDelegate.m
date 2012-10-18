//
//  AppDelegate.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "AppDelegate.h"
#import "MASPreferencesWindowController.h"
#import "ConfigurationPreferencesViewController.h"

@implementation AppDelegate

@synthesize statusItem = _statusItem ;
@synthesize configuration = _configuration ;
@synthesize preferencesController = _preferencesController ;

- (void)dealloc {
  [super dealloc];
}

- (id) init {
  if((self = [super init])) {
    self.configuration = [[Configuration alloc] init] ;
  }
  return self ;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [[NSApplication sharedApplication] activateIgnoringOtherApps:NO];
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

- (void) launchPreferences:(id) sender {
  NSLog(@"launchPreferences") ;
  if(! self.preferencesController) {
    NSArray *controllers = @[ [ConfigurationPreferencesViewController controllerForConfiguration: self.configuration]] ;
    self.preferencesController = [[MASPreferencesWindowController alloc] initWithViewControllers:controllers title: @"Preferences"] ;
  }
  [self.preferencesController showWindow:nil] ;
}
@end
