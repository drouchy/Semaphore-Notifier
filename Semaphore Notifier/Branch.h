//
//  Branch.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMXObject.h"
#import "SemaphoreResource.h"
#import "Project.h"

@interface Branch : SemaphoreResource

@property (nonatomic) NSNumber *branchId ;
@property (nonatomic) NSString  *name ;
@property (nonatomic) NSURL *url ;
@property (nonatomic) NSURL *statusUrl ;
@property (nonatomic) NSURL *historyUrl ;
@property (readonly, nonatomic) NSMutableArray *builds ;
@property (nonatomic, weak) id project ;

@end
