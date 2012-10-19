//
//  Branch.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "Branch.h"

int const BuildStatusNone = 0 ;
int const BuildStatusSuccess = 1 ;
int const BuildStatusFailure = 2 ;
int const BuildStatusUnknown = 3 ;

@implementation Branch

- (id) init {
  if((self = [super init])) {
    self.status = [NSNumber numberWithInt: BuildStatusNone] ;
  }
  return self ;
}
@end
