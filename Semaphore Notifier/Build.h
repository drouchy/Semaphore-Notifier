//
//  BuildInformation.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Build.h"
#import "SMXObject.h"
#import "Constants.h"

@interface Build : SMXObject

@property (copy, nonatomic) NSNumber *number ;
@property (copy, nonatomic) NSURL *url ;
@property (copy, nonatomic) NSDate *startedAt ;
@property (copy, nonatomic) NSDate *finishedAt ;
@property (nonatomic)       ResourceStatus status ;

- (void) updateFromJson: (NSDictionary *) json ;
@end
