//
//  LocalNotifier.h
//  Semaphore Notifier
//
//  Created by David Rouchy on 04/11/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Branch.h"
#import "Constants.h"

@interface LocalNotifier : NSObject

+ (void) notifyForNewBuildOnBranch:(Branch *) branch ;

@end
