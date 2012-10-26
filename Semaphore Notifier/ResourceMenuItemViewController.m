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
@end
