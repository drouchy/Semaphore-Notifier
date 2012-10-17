//
//  StatusBarMenuSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "SpecHelper.h"
#import "AppDelegate.h"

//
//  AppDelegateSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "AppDelegate.h"
#import "SpecHelper.h"

SpecBegin(AppDelegateStatusMenuSpec)

describe(@"AppDelegate", ^{
  __block AppDelegate *delegate ;
  __block NSApplication *application;
  
  beforeEach(^{
    application = [NSApplication sharedApplication];
    [NSBundle loadNibNamed:@"MainMenu" owner:application];
    delegate = [application delegate] ;
  }) ;

  afterEach(^{
    [[NSStatusBar systemStatusBar] removeStatusItem:delegate.statusItem] ;
  }) ;

  describe(@"statusMenu", ^{
    __block NSMenu *statusMenu ;
    
    beforeEach(^{
      [delegate applicationDidFinishLaunching: nil] ;
      statusMenu = delegate.statusItem.menu ;
    }) ;
  }) ;
});
SpecEnd
