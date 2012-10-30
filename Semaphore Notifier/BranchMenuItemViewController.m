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
  [super awakeFromNib] ;
  [self performSelectorOnMainThread: @selector(registerAsObserver) withObject: nil waitUntilDone: YES] ;
  //[self registerAsObserver] ;
  [self queryBranchBuild] ;
}

- (void) queryBranchBuild {
  NSLog(@"Requesting the last build of branch %@", self.branch.name) ;
  __block SemaphoreHttpRequestExecutor *request = [SemaphoreHttpRequestExecutor requestForResource: self.resource delegate: self] ;
  [request execute: ^{} statusBlock: ^(ResourceStatus status){ self.resource.status = status ; }] ;
}

- (Branch *) branch {
  return (Branch *) self.resource ;
}

- (NSImage *) statusImage {
  NSString *imageName = nil ;
  switch([self.resource status]) {
    case ResourceStatusNone:
    case ResourceStatusUnknown:
    case ResourceStatusError:
      imageName = @"statusUnknown" ;
      break ;
    case ResourceStatusPending:
      imageName = @"statusPending" ;
      break ;
    case ResourceStatusSuccess:
      imageName = @"statusSuccess" ;
      break ;
    case ResourceStatusFailure:
      imageName = @"statusFailure" ;
      break ;
    default:
      imageName = @"statusUnknown" ;
  }

  NSLog(@"status image: %@", imageName) ;
  return [NSImage imageNamed: imageName] ;
}

- (void)registerAsObserver {
  NSLog(@"Register the observer for %@", self.resource) ;
  [self.resource addObserver:self
                  forKeyPath:@"status"
                     options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                     context:@"KVO_CONTEXT_BRANCH_STATUS_CHANGED"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  
  NSLog(@"Branch <-- observeValueForKeyPath --> %@ (%@) -- %@", object, keyPath, context) ;
  if ([keyPath isEqual:@"status"]) {
    NSLog(@"====> change status image") ;
    [self willChangeValueForKey: @"statusImage"] ;
    [self didChangeValueForKey:  @"statusImage"] ;
  }
  [super observeValueForKeyPath: keyPath ofObject:object change:change context:context] ;
}

@end
