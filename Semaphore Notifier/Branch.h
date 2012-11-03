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
#import "Build.h"

@interface Branch : SemaphoreResource

@property (nonatomic) NSNumber *branchId ;
@property (nonatomic) NSString  *name ;
@property (nonatomic) NSURL *url ;
@property (nonatomic) NSURL *statusUrl ;
@property (nonatomic) NSURL *historyUrl ;
@property (readonly, nonatomic) NSMutableArray *builds ;
@property (weak) id project ;

+ branchOfProject: (id) project withName: (NSString *) name ;

- (void) updateFromJson: (NSDictionary *) json ;
- (void) addBuild: (Build *) build ;

@end
