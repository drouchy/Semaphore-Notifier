//
//  BranchMenuItemViewController.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 19/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "BranchMenuItemViewController.h"
#import "SemaphoreHttpRequestExecutor.h"

@interface BranchMenuItemViewController ()

@end

@implementation BranchMenuItemViewController

+ (id) controllerWithBranch: (Branch *) aBranch {
  return[[BranchMenuItemViewController alloc] initWithBranch: aBranch] ;
}

- (id) initWithBranch: (Branch *) aBranch {
  self = [super initWithNibName:@"BranchMenuItemView" bundle:[NSBundle bundleForClass: [self class]]];
  if (self) {
      self.resource = aBranch ;
  }
  
  return self;
}

- (void) awakeFromNib {
  [self.branch  addObserver:self
                 forKeyPath:@"status"
                    options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                    context:NULL];
  
  [self queryBuildStatus] ;
  
}

- (void) queryBuildStatus {
  NSLog(@"Query Build status %@", self.branch.name) ;
  __block SemaphoreHttpRequestExecutor *request = [SemaphoreHttpRequestExecutor requestForResource: self.resource] ;
  [request execute: ^{}
       statusBlock: ^(ResourceStatus status){ [self updateResourceStatus: status] ; }] ;
}

- (Branch *) branch {
  return (Branch *) self.resource ;
}

- (NSImage *) statusImage {
  return [NSImage imageNamed: [self statusImageName]] ;
}

- (NSString *) statusImageName {
  switch([self.branch status]) {
    case ResourceStatusNone:
    case ResourceStatusLoading:
    case ResourceStatusUnknown:
      return @"NSStatusNone" ;
      break ;
    case ResourceStatusPending:
      return @"NSStatusPartiallyAvailable" ;
      break ;
    case ResourceStatusFailure:
      return @"NSStatusUnavailable" ;
      break ;
    case ResourceStatusSuccess:
      return @"NSStatusAvailable" ;
      break ;
    case ResourceStatusError:
    default:
      return @"NSCaution" ;
  }
}
@end
