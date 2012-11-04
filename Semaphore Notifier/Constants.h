//
//  Constants.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ResourceStatus : NSInteger {
  ResourceStatusNone,
  ResourceStatusLoading,
  ResourceStatusPending,
  ResourceStatusSuccess,
  ResourceStatusFailure,
  ResourceStatusUnknown,
  ResourceStatusError
} ResourceStatus ;

FOUNDATION_EXPORT NSString *const SemaphoreApiUrl ;
FOUNDATION_EXPORT NSString *const NewBuildNotification;