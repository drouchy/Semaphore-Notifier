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

- (void) awakeFromNib {
  [super awakeFromNib] ;
}

- (void) dealloc {
  [self.resource removeObserver: self forKeyPath: @"status"] ;
}

- (void) showIndicator {
  if(self.resource.status == ResourceStatusPending) {
    NSLog(@"show indicator %@", [self.resource class]) ;
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
  //_menuItem.submenu.delegate = self ;
  return _menuItem ;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  
  NSLog(@"Resource <-- observeValueForKeyPath --> %@", keyPath) ;
  if ([keyPath isEqual:@"status"]) {
    [self willChangeValueForKey: @"shouldHideCautionImage"] ;
    [self willChangeValueForKey: @"shouldHideSubMenuImage"] ;
    [self showIndicator] ;
    [self didChangeValueForKey: @"shouldHideCautionImage"] ;
    [self didChangeValueForKey: @"shouldHideSubMenuImage"] ;

  }
}

- (Boolean) shouldHideCautionImage {
  return self.resource.status != ResourceStatusError ;
}

- (Boolean) shouldHideSubMenuImage {
  switch (self.resource.status) {
    case ResourceStatusError:
    case ResourceStatusPending:
    case ResourceStatusNone:
    case ResourceStatusUnknown:
      return YES ;
      break;
    default:
      return NO ;
  }
}
@end
