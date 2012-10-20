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

@synthesize userDefaults = _userDefaults ;

+ (id) providerWithSettings: (NSDictionary *) settings {
  UserDefaultsProvider *provider = [[self alloc] init] ;
  NSUserDefaults *defaults = [[NSUserDefaults alloc] init] ;
  [defaults registerDefaults: settings] ;
  
  for(NSString *key in [settings allKeys]) {
    [defaults setObject: settings[key] forKey: key] ;
  }
  
  provider.userDefaults = defaults ;
  return provider ;
}

- (NSUserDefaults *) userDefaults {
  if(_userDefaults) {
    return _userDefaults ;
  }
  return [NSUserDefaults standardUserDefaults] ;
}
@end
