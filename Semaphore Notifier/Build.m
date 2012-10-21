//
//  BuildInformation.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "Build.h"

@implementation Build

+ (id) buildWithJson:(NSDictionary *) json {
  Build *build = [[Build alloc] init] ;
  [build parse: json] ;
  return build ;
}

- (void) parse: (NSDictionary *) json {
  NSLog(@"build parse json: %@", json) ;
  self.number = json[@"build_number"] ;
  self.url = [NSURL URLWithString: json[@"build_url"]];
  self.startedAt = [NSDate dateWithString: json[@"started_at"]];
  self.finishedAt = [NSDate dateWithString: json[@"finished_at"]];
  self.status = [self parseStatus: json[@"result"]];
}

- (int) parseStatus: (NSString *) result {
  if([result isEqual: @"passed"]) {
    return BuildStatusSuccess ;
  }
  if([result isEqual: @"failed"]) {
    return BuildStatusFailure ;
  }
  return BuildStatusUnknown ;
}
@end
