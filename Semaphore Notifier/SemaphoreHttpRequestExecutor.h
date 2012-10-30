//
//  SemaphoreHttpConnectionRequest.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 27/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SemaphoreResource.h"

@interface SemaphoreHttpRequestExecutor : NSObject

@property (weak) SemaphoreResource *resource ;

+ (id) requestForResource: (SemaphoreResource *) aResource delegate: (id) delegate;

- (void) execute: (void (^)())block statusBlock: (void (^)(ResourceStatus)) statusBlock;

@end
