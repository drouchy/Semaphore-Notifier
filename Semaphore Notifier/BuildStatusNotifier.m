//
//  BuildStatusNotifier.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 04/11/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "BuildStatusNotifier.h"
#import "Branch.h"
#import "Build.h"

@implementation BuildStatusNotifier

- (id) init {
  if((self = [super init])) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNewBuildNotification:) name:NewBuildNotification object:nil];
  }
  return self ;
}

- (void) handleNewBuildNotification: (NSNotification *) notification {
  NSLog(@"New build notification: %@", notification) ;
  Branch *branch = notification.object ;

  if([branch.builds count] < 2)
    return ;

  Build *lastBuild = branch.builds[0] ;
  Build *previousBuild = branch.builds[1] ;
  
  switch(lastBuild.status) {
    case ResourceStatusFailure:
      if(previousBuild.status == ResourceStatusFailure)
        [self notifyBranchStillFailling: branch] ;
      else
        [self notifyBranchIsNowFailling: branch] ;
      break ;
    case ResourceStatusSuccess:
      if(previousBuild.status == ResourceStatusFailure)
        [self notifyBranchBackToSuccess: branch] ;
      break ;
    default:
      NSLog(@"nothing to notify about");
  }
}

- (void) notifyBranchBackToSuccess: (Branch *) branch {
  NSLog(@"Schedule a notification (%@) for success", branch.name) ;
  
  NSString *title = [NSString stringWithFormat:  @"Build of %@ has been fixed", [branch.project name]] ;
  NSString *text = [NSString stringWithFormat:  @"%@\n%@", branch.lastBuild.commitAuthor, branch.lastBuild.commitMessage] ;
  NSString *subTitle = [NSString stringWithFormat: @"branch %@", branch.name ] ;
  
  [self sendNotification: title withSubtitle: subTitle andText: text] ;
}

- (void) notifyBranchStillFailling: (Branch *) branch {
  NSString *title = [NSString stringWithFormat:  @"Build of %@ is still broken", [branch.project name]] ;
  NSString *subTitle = [NSString stringWithFormat: @"branch %@", branch.name ] ;
  NSString *text = [NSString stringWithFormat:  @"%@\n%@", branch.lastBuild.commitAuthor, branch.lastBuild.commitMessage] ;
  [self sendNotification: title withSubtitle: subTitle andText: text] ;
}

- (void) notifyBranchIsNowFailling: (Branch *) branch {
  NSString *title = [NSString stringWithFormat:  @"Build of %@ has failed", [branch.project name]] ;
  NSString *subTitle = [NSString stringWithFormat: @"branch %@", branch.name ] ;
  NSString *text = [NSString stringWithFormat:  @"%@\n%@", branch.lastBuild.commitAuthor, branch.lastBuild.commitMessage] ;
  [self sendNotification: title withSubtitle: subTitle andText: text] ;
}

- (void) sendNotification: (NSString *) title withSubtitle:(NSString *) subtitle andText: (NSString *) text {
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
