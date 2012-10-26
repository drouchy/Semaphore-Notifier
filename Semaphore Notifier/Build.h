//
//  BuildInformation.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Build.h"
#import "SemaphoreResource.h"
#import "Constants.h"

@interface Build : SemaphoreResource

@property (copy, nonatomic) NSNumber *number ;
@property (copy, nonatomic) NSURL *url ;
@property (copy, nonatomic) NSDate *startedAt ;
@property (copy, nonatomic) NSDate *finishedAt ;

- (void) updateFromJson: (NSDictionary *) json ;
@end
