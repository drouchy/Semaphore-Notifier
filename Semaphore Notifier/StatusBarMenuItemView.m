//
//  StatusBarMenuItemView.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 20/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "StatusBarMenuItemView.h"

@implementation StatusBarMenuItemView

enum AppleAquaColorVariant {
  
  AppleAquaColorBlue = 1,
  AppleAquaColorGraphite = 6,
};


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
  BOOL isHighlighted = [self.enclosingMenuItem isHighlighted];
  if (isHighlighted) {
    [[NSColor selectedMenuItemColor] set];
    [NSBezierPath fillRect:dirtyRect];
  } else {
    [super drawRect: dirtyRect];
  }
}

@end
