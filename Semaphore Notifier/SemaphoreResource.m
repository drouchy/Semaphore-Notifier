//
//  SemaphoreResource.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 20/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "SemaphoreResource.h"

static UserDefaultsProvider *provider ;

@implementation SemaphoreResource

+ (void) registerUserDefaultsProvider: (UserDefaultsProvider *) aProvider {
  provider = aProvider ;
}

- (NSString *) authToken {
  return [[self loadUserDefaults] objectForKey: @"authKey"] ;
}

- (NSUserDefaults *) loadUserDefaults {
  if(!provider) {
    provider = [[UserDefaultsProvider alloc] init] ;
  }
  return [provider userDefaults] ;
}

@end