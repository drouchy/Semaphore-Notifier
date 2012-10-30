//
//  BuildInformation.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "Build.h"

@implementation Build

- (id) init {
  if((self = [super init])) {
    self.status = ResourceStatusNone ;
  }
  return self ;
}

- (void) updateFromJson: (NSDictionary *) json {
  _number = [NSNumber numberWithInt: [json[@"build_number"] intValue]];
  _url = [NSURL URLWithString: json[@"build_url"]] ;
  
  NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
  _startedAt = [dateFormatter dateFromString: json[@"started_at"]];
  _finishedAt = [dateFormatter dateFromString: json[@"finished_at"]];

  self.status = [self parseStatus:json[@"result"]] ;
}

- (ResourceStatus) parseStatus: (NSString *) status {
  NSLog(@"===> Parsing status %@", status) ;
  if([status isEqualToString: @"passed"]) {
    return ResourceStatusSuccess ;
  } else if([status isEqualToString: @"failed"]) {
    return ResourceStatusFailure ;
  } else if([status isEqualToString: @"pending"]) {
    return ResourceStatusPending ;
  }
  return ResourceStatusUnknown ;
}
@end
