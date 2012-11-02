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

- (void) showIndicators {
  switch (self.resource.status) {
    case ResourceStatusLoading:
      [self startAnimation] ;
      break ;
    default:
      [self stopAnimation] ;
      break ;
  }
}

- (void) startAnimation {
  NSLog(@"show indicator") ;
  [self.loadingIndicator performSelector:@selector(startAnimation:)
                              withObject:self
                              afterDelay:0.0
                                 inModes:@[NSEventTrackingRunLoopMode]];
}

- (void) stopAnimation {
  NSLog(@"stopping animation") ;
  [self.loadingIndicator stopAnimation:nil] ;
}

- (NSMenuItem *) buildMenuItem {
  _menuItem = [[NSMenuItem alloc] init] ;
  _menuItem.view = self.view ;
  _menuItem.submenu = [[NSMenu alloc] init] ;
  return _menuItem ;
}


- (Boolean) shouldHideTheErrorImage {
  switch(self.resource.status) {
    case ResourceStatusError:
    case ResourceStatusUnknown:
      return NO ;
    default:
      return YES ;
  }
}

- (void) updateResourceStatus: (ResourceStatus) status {
  self.resource.status = status ;
}
@end
