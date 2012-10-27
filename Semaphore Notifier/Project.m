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

- (id) init {
  if((self = [super init])) {
    self.name = @"Set the project name" ;
    self.apiKey = @"Set the project API key" ;
    self.enabled = YES ;
    self.branches = [NSMutableArray array] ;
  }
  return self ;
}

- (NSURL *) branchListUrl {
  NSString *branchListUrl = [NSString stringWithFormat: @"%@/projects/%@/branches?auth_token=%@", SemaphoreApiUrl, self.apiKey, [self authToken]] ;
  return [NSURL URLWithString:branchListUrl];
}

- (void) parseJson: (NSArray *) json {
  for(NSDictionary *entry in json) {
    NSLog(@"Loading (%@) branch %@", self.name, entry[@"name"]) ;
    Branch *branch = [[Branch alloc] init] ;
    branch.branchId = entry[@"id"] ;
    branch.name = entry[@"name"] ;
    
    [_branches addObject: branch] ;
  }
}

- (NSURL *) requestUrl {
  return [self branchListUrl] ;
}
@end
