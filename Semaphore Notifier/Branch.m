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
    _builds = [NSMutableArray array] ;
  }
  return self ;
}

- (int) lastStatus {
  return BuildStatusNone ;
}

- (void) updateFromJson: (NSDictionary *) json {
  _url = json[@"branch_url"];
  _statusUrl = json[@"branch_status_url"];
  _historyUrl = json[@"branch_history_url"];
}
@end
