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

@synthesize project = _project ;

+ (id) branchWithProject: (id) project {
  Branch *branch = [[self alloc] init] ;
  branch.project = project ;
  return branch ;
}

- (id) init {
  if((self = [super init])) {
    self.builds = [[NSMutableArray alloc] init] ;
  }
  return self ;
}

- (int) lastStatus {
  if([self.builds count] == 0) {
    return BuildStatusNone ;
  }
  Build *lastBuild = self.builds[0] ;
  return lastBuild.status ;
}

- (NSURL *) lastBuildUrl {
  NSString *apiKey = [self.project performSelector: @selector(apiKey)] ;
  NSString *branchListUrl = [NSString stringWithFormat: @"%@/projects/%@/%@/status?auth_token=%@", SemaphoreApiUrl, apiKey, self.branchId, [self authToken]] ;
  return [NSURL URLWithString:branchListUrl];
}

- (void) loadBuild: (NSDictionary *) json {
  if(json[@"build_number"] != [self lastBuild].number) {
    NSLog(@"add the new build %@ on branch %@", json[@"build_number"], self.name) ;
    [self.builds insertObject:[Build buildWithJson: json] atIndex:0] ;
    if([self.builds count] > 2) {
      [self.builds removeLastObject] ;
    }
  } else {
    NSLog(@"no new build") ;
  }
}

- (Build *) lastBuild {
  if([self.builds count] == 0) {
    return nil ;
  }
  return [self.builds objectAtIndex: 0] ;
}
@end
