//
//  Branch.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "Branch.h"
#import "Constants.h"
#import "Build.h"

@implementation Branch

- (id) init {
  if((self = [super init])) {
    _builds = [NSMutableArray array] ;
  }
  return self ;
}

- (int) lastStatus {
  return ResourceStatusNone ;
}

- (void) updateFromJson: (NSDictionary *) json {
  _url = json[@"branch_url"];
  _statusUrl = json[@"branch_status_url"];
  _historyUrl = json[@"branch_history_url"];

  Build *build = [[Build alloc] init] ;
  [build updateFromJson: json] ;
  [self addBuild: build] ;
}

- (void) addBuild: (Build *) build {
  if([self lastBuild].number != build.number) {
    [_builds insertObject: build atIndex:0] ;
    if([_builds count] > 2) {
      [_builds removeLastObject] ;
    }
  }
}

- (Build *) lastBuild {
  if([_builds count] == 0) return nil ;
  return _builds[0] ;
}
@end
