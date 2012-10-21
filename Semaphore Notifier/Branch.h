//
//  Branch.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SemaphoreResource.h"
#import "Build.h"

@interface Branch : SemaphoreResource

@property (copy, nonatomic) NSNumber *branchId ;
@property (copy, nonatomic) NSString  *name ;
@property (copy, nonatomic) NSURL *url ;
@property (copy, nonatomic) NSURL *statusUrl ;
@property (copy, nonatomic) NSURL *historyUrl ;
@property (nonatomic) NSMutableArray *builds ;
@property (weak) id project ;

+ (id) branchWithProject: (id) project ;

- (int) lastStatus ;
- (NSURL *) lastBuildUrl ;
- (void) loadBuild: (NSDictionary *) buildJson ;
@end
