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
#import "ProjectsPreferencesViewController.h"
#import "AdvancedPreferencesViewController.h"
#import "Project.h"
#import "ProjectMenuItemViewController.h"

@implementation AppDelegate

@synthesize statusItem = _statusItem ;
@synthesize preferencesController = _preferencesController ;

- (void)dealloc {
  [super dealloc];
}

+ (void) initialize {
  NSDictionary *defaults = @{
    @"authKey": @"",
    @"projects": [NSMutableArray array]
  } ;
  
  [[NSUserDefaults standardUserDefaults] registerDefaults: [defaults mutableCopy]] ;
  NSLog(@"registered defaults %@", defaults) ;
}

- (id) init {
  if((self = [super init])) {
  }
  return self ;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
}

- (void) awakeFromNib {
  self.statusItem = [self createStatusItem] ;
  [self loadProjects] ;
}

- (NSStatusItem *) createStatusItem {
  NSStatusItem *statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSVariableStatusItemLength] ;
  statusItem.highlightMode = YES ;
  statusItem.title = @"CI" ;
  statusItem.image = [NSImage imageNamed: @"statusIconTemplate"] ;
  statusItem.menu = self.statusMenu ;
  
  return statusItem ;
}

- (void) loadProjects {

}

- (void) launchPreferences:(id) sender {
  NSLog(@"launchPreferences") ;

  if(! self.preferencesController) {
    NSArray *controllers = @[
                                [ConfigurationPreferencesViewController controller],
                                [ProjectsPreferencesViewController controller],
                                [AdvancedPreferencesViewController controller]
                            ] ;
    self.preferencesController = [[MASPreferencesWindowController alloc] initWithViewControllers:controllers title: @"Preferences"] ;
  }
  [self.preferencesController showWindow:nil] ;
}
@end
