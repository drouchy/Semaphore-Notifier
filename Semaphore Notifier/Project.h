//
//  Project.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SemaphoreResource.h"
#import "Branch.h"

@interface Project : SemaphoreResource

@property (copy, nonatomic)   NSString *name ;
@property (copy, nonatomic)   NSString *apiKey ;
@property (nonatomic)         Boolean enabled ;
@property (strong, nonatomic) NSMutableArray *branches ;

+ (id) projectWithName: (NSString *) aName andKey: (NSString *) aKey ;

- (NSURL *) branchListUrl ;
@end
