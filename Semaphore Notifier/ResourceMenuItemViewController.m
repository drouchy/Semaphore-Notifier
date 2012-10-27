//
//  ResourceMenuItemViewController.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 26/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "ResourceMenuItemViewController.h"

@interface ResourceMenuItemViewController ()

@end

@implementation ResourceMenuItemViewController

- (id) initWithResource: (SemaphoreResource *) aResource {
  if((self = [super init])) {
    _resource = aResource ;
  }
  return self ;
}

- (void) showIndicator {
  if(self.resource.status == ResourceStatusPending) {
    NSLog(@"show indicator") ;
    [self.loadingIndicator performSelector:@selector(startAnimation:)
                                withObject:self
                                afterDelay:0.0
                                   inModes: @[NSEventTrackingRunLoopMode]];
    
  } else {
    NSLog(@"stopping animation") ;
    [self.loadingIndicator stopAnimation:nil] ;
  }
}

- (NSMenuItem *) buildMenuItem {
  _menuItem = [[NSMenuItem alloc] init] ;
  _menuItem.view = self.view ;
  _menuItem.submenu = [[NSMenu alloc] init] ;
  return _menuItem ;
}

@end
