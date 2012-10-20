//
//  Constants.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "Constants.h"

NSString *SemaphoreApiUrl = @"https://semaphoreapp.com/api/v1";

int const BuildStatusNone       = 0 ;
int const BuildStatusSuccess    = 1 ;
int const BuildStatusFailure    = 2 ;
int const BuildStatusUnknown    = 3 ;
int const ResourceStatusNone    = 4 ;
int const ResourceStatusSuccess = 5 ;
int const ResourceStatusFailure = 6 ;
int const ResourceStatusLoading = 7 ;