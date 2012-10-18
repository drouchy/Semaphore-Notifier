//
//  Configuration.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "Configuration.h"
#import "Project.h"

@implementation Configuration

@synthesize authKey = _authKey ;
@synthesize projects = _projects ;

- (id) init {
  if((self = [super init])) {
    _projects = [[NSMutableArray alloc] init] ;
  }
  return self ;
}
@end
