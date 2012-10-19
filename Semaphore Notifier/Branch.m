//
//  Branch.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "Branch.h"
#import "Constants.h"

@implementation Branch

- (id) init {
  if((self = [super init])) {
  }
  return self ;
}

- (int) lastStatus {
  return BuildStatusNone ;
}
@end
