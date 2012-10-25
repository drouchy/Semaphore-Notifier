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
@property (strong, nonatomic) NSArray *projects ;
@property (strong, nonatomic) NSArray *projectMenuControllers ;
@end

@implementation AppDelegate

@synthesize statusItem = _statusItem ;
@synthesize preferencesController = _preferencesController ;


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
  [self loadProjectMenuItems] ;
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
  
  NSMutableArray *array = [NSMutableArray array] ;
  for(NSDictionary *entry in [userDefaults objectForKey: @"projects"]) {
    Project *project = [[Project alloc] init] ;
    project.name = entry[@"name"] ;
    project.enabled = [entry[@"enabled"] boolValue] ;
    project.apiKey = entry[@"apiKey"] ;

    [array addObject: project] ;
  }
  
  self.projects = [array copy] ;
}

- (void) loadProjectMenuItems {
  NSLog(@"loading projects menu items %@", _projects) ;
  int i = 2 ;
  NSMutableArray *controllers = [NSMutableArray array] ;
  for(Project *project in _projects) {
    NSLog(@"loading project %@", project.name) ;
    if(project.enabled) {
      ProjectMenuItemViewController *controller = [ProjectMenuItemViewController controllerWithProject: project] ;
      [controllers addObject: controller] ;

      [self.statusMenu insertItem: [controller buildMenuItem] atIndex:i] ;
      i++ ;
    }
  }
  _projectMenuControllers = [controllers copy] ;
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

// Don't know how to test that
- (void)menuWillOpen:(NSMenu *)menu {
  NSTimer *timer = [NSTimer timerWithTimeInterval:0 target:self selector:@selector(animateProgress:) userInfo:nil repeats:NO];
  [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSEventTrackingRunLoopMode];
}

- (void)animateProgress:(NSTimer *)timer {
  NSLog(@"animate progress: %@", self.projectMenuControllers) ;
  for(ProjectMenuItemViewController *controller in self.projectMenuControllers) {
    [controller showIndicator] ;
  }
}
@end
