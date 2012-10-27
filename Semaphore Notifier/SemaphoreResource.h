//
//  SemaphoreResource.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 20/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMXObject.h"
#import "UserDefaultsProvider.h"
#import "Constants.h"

@interface SemaphoreResource : SMXObject

@property (nonatomic) ResourceStatus status ;

+ (void) registerUserDefaultsProvider: (UserDefaultsProvider *) provider ;

- (NSString *) authToken ;
- (void) parseJson: (NSArray *) json ;
- (NSURL *) requestUrl ;
@end
