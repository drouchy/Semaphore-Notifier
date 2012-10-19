//
//  Branch.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Foundation/Foundation.h>

extern int const BuildStatusNone ;
extern int const BuildStatusSuccess ;
extern int const BuildStatusFailure ;
extern int const BuildStatusUnknown ;

@interface Branch : NSObject

@property (copy, nonatomic) NSString  *name ;
@property (copy, nonatomic) NSNumber *status ;

@end
