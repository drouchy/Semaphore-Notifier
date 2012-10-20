//
//  UserDefaultsProvider.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 20/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "UserDefaultsProvider.h"

@interface UserDefaultsProvider()
@property (retain, nonatomic) NSUserDefaults *userDefaults ;
@end

@implementation UserDefaultsProvider

+ (id) providerWithSettings: (NSDictionary *) settings {
  UserDefaultsProvider *provider = [[self alloc] init] ;
  NSUserDefaults *defaults = [[NSUserDefaults alloc] init] ;
  [defaults registerDefaults: settings] ;
  return provider ;
}

- (NSUserDefaults *) userDefaults {
  if(self.userDefaults) {
    return self.userDefaults ;
  }
  return [NSUserDefaults standardUserDefaults] ;
}
@end
