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

- (ResourceStatus) status {
  if([self lastBuild]) {
    return [self lastBuild].status ;
  }
  return super.status ;
}

- (void) parseJson: (NSDictionary *) json {
  NSLog(@"==> parse JSON %@", json) ;
  _url = [NSURL URLWithString: json[@"branch_url"]];
  _statusUrl = [NSURL URLWithString: json[@"branch_status_url"]];
  _historyUrl = [NSURL URLWithString: json[@"branch_history_url"]];

  Build *build = [[Build alloc] init] ;
  [build updateFromJson: json] ;
  [self addBuild: build] ;
}

- (void) addBuild: (Build *) build {
  if([self lastBuild].number != build.number) {
    [self willChangeValueForKey: @"status"] ;
    [_builds insertObject: build atIndex:0] ;
    [self didChangeValueForKey: @"status"] ;
    if([_builds count] > 2) {
      [_builds removeLastObject] ;
    }
  }
}

- (Build *) lastBuild {
  if([_builds count] == 0) return nil ;
  return _builds[0] ;
}

- (NSURL *) requestUrl {
  if(self.statusUrl) {
    return self.statusUrl ;
  } else {
    NSString *url = [NSString stringWithFormat: @"%@/projects/%@/%@/status?auth_token=%@", SemaphoreApiUrl,
                    [self.project apiKey], self.branchId,[self authToken]] ;
    return  [NSURL URLWithString: url] ;
  }
}
@end
