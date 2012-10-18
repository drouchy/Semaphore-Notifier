//
//  ConfigurationPreferenceViewController.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "ConfigurationPreferencesViewController.h"

@interface ConfigurationPreferencesViewController ()

@end

@implementation ConfigurationPreferencesViewController

- (id)init
{
    self = [super initWithNibName:@"ConfigurationPreferencesView" bundle: [NSBundle bundleForClass: [self class]]];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (id) controller {
  ConfigurationPreferencesViewController *controller = [[self alloc] init] ;
  return controller ;
}

#pragma mark -
#pragma mark MASPreferencesViewController

- (NSString *)identifier {
  return @"GeneralPreferences";
}

- (NSImage *)toolbarItemImage {
  return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

- (NSString *)toolbarItemLabel {
  return @"General";
}

@end
