//
//  AdvancedPreferencesViewController.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 18/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "AdvancedPreferencesViewController.h"

@interface AdvancedPreferencesViewController ()

@end

@implementation AdvancedPreferencesViewController

- (id)init {
  self = [super initWithNibName:@"AdvancedPreferencesView" bundle: [NSBundle bundleForClass: [self class]]];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

+ (id) controllerForConfiguration: (Configuration *) aConfiguration {
  AdvancedPreferencesViewController *controller = [[self alloc] init] ;
  [controller setConfiguration: aConfiguration] ;
  return controller ;
}

#pragma mark -
#pragma mark MASPreferencesViewController

- (NSString *)identifier {
  return @"AdvancedPreferences";
}

- (NSImage *)toolbarItemImage {
  return [NSImage imageNamed:NSImageNameAdvanced];
}

- (NSString *)toolbarItemLabel {
  return @"Advanced";
}


@end
