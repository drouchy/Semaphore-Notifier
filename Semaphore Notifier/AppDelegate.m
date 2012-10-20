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

static UserDefaultsProvider *provider ;

@interface AppDelegate()
@property (retain, nonatomic) NSMutableArray *projects ;
@end

@implementation AppDelegate

@synthesize statusItem = _statusItem ;
@synthesize preferencesController = _preferencesController ;

- (void)dealloc {
  [super dealloc];
}

+ (void) initialize {
  [self registerUserDefaults] ;
}

+ (void) registerUserDefaults {
  NSDictionary *defaults = @{
                              @"authKey": @"",
                              @"projects": [NSMutableArray array]
                            } ;
  
  [[NSUserDefaults standardUserDefaults] registerDefaults: [defaults mutableCopy]] ;
  NSLog(@"registered defaults %@", defaults) ;
}

+ (void) registerUserDefaultsProvider: (UserDefaultsProvider *) aProvider {
  provider = aProvider ;
}

- (id) init {
  if((self = [super init])) {
    [self loadProjects] ;
  }
  return self ;
}

- (NSUserDefaults *) loadUserDefaults {
  if(!provider) {
    provider = [[UserDefaultsProvider alloc] init] ;
  }
  return [provider userDefaults] ;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
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

- (void) loadProjects {
  NSLog(@"loading projects") ;
  NSUserDefaults *userDefaults = [self loadUserDefaults] ;
  
  self.projects = [NSMutableArray array] ;
  for(NSDictionary *entry in [userDefaults objectForKey: @"projects"]) {
    Project *project = [[Project alloc] init] ;
    project.name = entry[@"name"] ;
    project.enabled = [entry[@"enabled"] boolValue] ;
    project.apiKey = entry[@"apiKey"] ;

    [self.projects addObject: project] ;
  }
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
