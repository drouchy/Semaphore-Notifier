//
//  LocalNotifier.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 04/11/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "LocalNotifier.h"

@implementation LocalNotifier

+ (void) notifyForNewBuildOnBranch:(Branch *) branch {
  NSLog(@"Notifying for new build on branch: %@", branch) ;
  [[NSNotificationCenter defaultCenter] postNotificationName:NewBuildNotification object:branch];
}

@end
