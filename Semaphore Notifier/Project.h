//
//  Project.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SemaphoreResource.h"

@interface Project : SemaphoreResource

@property (copy, nonatomic) NSString *name ;
@property (copy, nonatomic) NSString *apiKey ;
@property (nonatomic)       Boolean enabled ;

+ (id) projectWithName: (NSString *) aName andKey: (NSString *) aKey ;

- (NSURL *) branchListUrl ;
@end
