//
//  Constants.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *SemaphoreApiUrl ;

typedef enum BuildStatus : NSInteger {
  BuildStatusNone,
  BuildStatusPending,
  BuildStatusSuccess,
  BuildStatusFailure,
  BuildStatusUnknown

} BuildStatus ;

typedef enum ResourceStatus : NSInteger {
  ResourceStatusNone,
  ResourceStatusSuccess,
  ResourceStatusFailure,
  ResourceStatusLoading
  
} ResourceStatus ;