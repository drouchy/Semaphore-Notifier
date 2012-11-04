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
#import "BuildStatusNotifier.h"

static UserDefaultsProvider *provider ;

@interface AppDelegate()
@property (strong, nonatomic) NSMutableArray *projects ;
@property (strong, nonatomic) NSMutableArray *projectMenuControllers ;
@property (strong, nonatomic) BuildStatusNotifier *notifier ;
@end

@implementation AppDelegate

@synthesize statusItem = _statusItem ;
@synthesize preferencesController = _preferencesController ;


+ (void) initialize {
  [self registerUserDefaults] ;
}

+ (void) registerUserDefaults {
  NSDictionary *defaults = @{
                              @"authKey"        : @"",
                              @"projects"       : [NSMutableArray array],
                              @"watchOutMaster" : @YES
                            } ;
  
  [[NSUserDefaults standardUserDefaults] registerDefaults: [defaults mutableCopy]] ;
  NSLog(@"registered defaults %@", defaults) ;
}

+ (void) registerUserDefaultsProvider: (UserDefaultsProvider *) aProvider {
  provider = aProvider ;
}

- (id) init {
  if((self = [super init])) {
    _notifier = [[BuildStatusNotifier alloc] init] ;
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
  
  _projects = [NSMutableArray array] ;
  for(NSDictionary *entry in [userDefaults objectForKey: @"projects"]) {
    Project *project = [[Project alloc] init] ;
    project.name = entry[@"name"] ;
    project.enabled = [entry[@"enabled"] boolValue] ;
    project.apiKey = entry[@"apiKey"] ;

    [_projects addObject: project] ;
  }  
}

- (void) loadProjectMenuItems {
  NSLog(@"loading projects menu items %@", _projects) ;
  _projectMenuControllers = [NSMutableArray array] ;
  for(Project *project in _projects) {
    NSLog(@"loading project %@", project.name) ;
    [self addMenuItemForProject: project] ;
  }
}

- (void) addMenuItemForProject: (Project *) project {
  if(project.enabled) {
    ProjectMenuItemViewController *controller = [ProjectMenuItemViewController controllerWithProject: project] ;
    [_projectMenuControllers addObject: controller] ;
    NSInteger index = [[self.statusMenu itemArray] count] - 4 ;
    [self.statusMenu insertItem: [controller buildMenuItem] atIndex: index] ;
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

// Don't know how to test that
- (void)menuWillOpen:(NSMenu *)menu {
  NSTimer *timer = [NSTimer timerWithTimeInterval:0 target:self selector:@selector(animateProgress:) userInfo:nil repeats:NO];
  [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSEventTrackingRunLoopMode];
}

- (void)animateProgress:(NSTimer *)timer {
  NSLog(@"animate progress: %@", self.projectMenuControllers) ;
  for(ProjectMenuItemViewController *controller in self.projectMenuControllers) {
    [controller showIndicators] ;
  }
}

- (void) refresh:(id) sender {
  NSLog(@"Refresh.....") ;
  for(ProjectMenuItemViewController *controller in self.projectMenuControllers) {
    [controller refresh] ;
  }
}
@end
