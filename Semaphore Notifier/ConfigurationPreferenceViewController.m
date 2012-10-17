//
//  ConfigurationPreferenceViewController.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "ConfigurationPreferenceViewController.h"

@interface ConfigurationPreferenceViewController ()

@end

@implementation ConfigurationPreferenceViewController

- (id)init
{
    self = [super initWithNibName:@"ConfigurationPreferenceView" bundle: [NSBundle bundleForClass: [self class]]];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (id) controllerForConfiguration: (Configuration *) aConfiguration {
  ConfigurationPreferenceViewController *controller = [[self alloc] init] ;
  [controller setConfiguration: aConfiguration] ;
  return controller ;
}
@end
