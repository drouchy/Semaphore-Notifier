//
//  Project.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "Project.h"

@implementation Project

@synthesize name = _name ;
@synthesize apiKey = _apiKey ;

+ (id) projectWithName: (NSString *) aName andKey: (NSString *) aKey {
  Project *project = [[self alloc] init] ;
  project.name = aName ;
  project.apiKey = aKey ;
  return project ;
}
@end
