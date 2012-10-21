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
    if([self.builds count] == 2) {
      [self checkBuildStatus] ;
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

- (Build *) previousBuild {
  if([self.builds count] < 2) {
    return nil ;
  }
  return [self.builds objectAtIndex: 1] ;
}

- (void) checkBuildStatus {
  Build *lastBuild = [self lastBuild] ;
  Build *previousBuild = [self previousBuild] ;

  if(lastBuild.status == BuildStatusFailure) {
     NSLog(@"Schedule a notification (%@) for failure", self.name) ;
    if(previousBuild.status == BuildStatusFailure) {
      NSString *title = [NSString stringWithFormat:  @"Build of %@ is still broken", [self.project name]] ;
      NSString *subTitle = [NSString stringWithFormat: @"branch %@", self.name ] ;
      NSString *text = [NSString stringWithFormat:  @"Later I'll add some details"] ;
      [self scheduleNotification: title withSubtitle: subTitle andText: text] ;
    } else {
      NSString *title = [NSString stringWithFormat:  @"Build of %@ has failed", [self.project name]] ;
      NSString *subTitle = [NSString stringWithFormat: @"branch %@", self.name ] ;
      NSString *text = [NSString stringWithFormat:  @"Later I'll add some details"] ;
      [self scheduleNotification: title withSubtitle: subTitle andText: text] ;
    }
  } else if(lastBuild.status == BuildStatusSuccess && previousBuild.status == BuildStatusFailure) {
    NSLog(@"Schedule a notification (%@) for success", self.name) ;
    NSString *title = [NSString stringWithFormat:  @"Build of %@ has been fixed", [self.project name]] ;
    NSString *text = [NSString stringWithFormat:  @"Later I'll add some details"] ;
    NSString *subTitle = [NSString stringWithFormat: @"branch %@", self.name ] ;

    [self scheduleNotification: title withSubtitle: subTitle andText: text] ;
  }
}

- (void) scheduleNotification: (NSString *) title withSubtitle:(NSString *) subtitle andText: (NSString *) text {
  NSLog(@"Schedule a notification (%@)", title) ;
  NSUserNotification *notification = [[NSUserNotification alloc] init];
  [notification setTitle: title];
  [notification setSubtitle: subtitle] ;
  [notification setInformativeText: text];
  [notification setDeliveryDate:[NSDate dateWithTimeIntervalSinceNow:0]];
  [notification setSoundName:NSUserNotificationDefaultSoundName];

  NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
  [center scheduleNotification:notification];
}
@end
