//
//  ProjectsPreferencesViewController.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "ProjectsPreferencesViewController.h"

@interface ProjectsPreferencesViewController ()

@end

@implementation ProjectsPreferencesViewController

- (id)init
{
  self = [super initWithNibName:@"ProjectsPreferencesView" bundle: [NSBundle bundleForClass: [self class]]];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

+ (id) controllerForConfiguration: (Configuration *) aConfiguration {
  ProjectsPreferencesViewController *controller = [[self alloc] init] ;
  [controller setConfiguration: aConfiguration] ;
  return controller ;
}

#pragma mark -
#pragma mark MASPreferencesViewController

- (NSString *)identifier {
  return @"ProjectsPreferences";
}

- (NSImage *)toolbarItemImage {
  return [NSImage imageNamed:NSImageNameEveryone];
}

- (NSString *)toolbarItemLabel {
  return @"Projects";
}

@end
