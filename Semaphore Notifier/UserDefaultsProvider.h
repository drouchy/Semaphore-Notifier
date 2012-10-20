//
//  UserDefaultsProvider.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 20/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsProvider : NSObject

+ (id) providerWithSettings: (NSDictionary *) settings ;

- (NSUserDefaults *) userDefaults ;
@end
