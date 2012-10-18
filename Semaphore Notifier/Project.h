//
//  Project.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMXObject.h"

@interface Project : SMXObject

@property (copy, nonatomic) NSString *name ;
@property (copy, nonatomic) NSString *apiKey ;

+ (id) projectWithName: (NSString *) aName andKey: (NSString *) aKey ;
@end
