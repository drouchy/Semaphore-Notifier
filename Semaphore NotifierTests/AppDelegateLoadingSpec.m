//
//  AppDelegateSpec.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 17/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "AppDelegate.h"
#import "SpecHelper.h"

SpecBegin(AppDelegateLoadingSpec)

describe(@"AppDelegate", ^{
  __weak AppDelegate *delegate ;
  __block NSApplication *application;
  
  beforeEach(^{
    application = [NSApplication sharedApplication];
    [NSBundle loadNibNamed:@"MainMenu" owner:application];
    delegate = [application delegate] ;
  }) ;

  afterEach(^{
    [[NSStatusBar systemStatusBar] removeStatusItem:delegate.statusItem] ;
  }) ;

  describe(@"awakeFromNib", ^{
    beforeEach(^{
      [delegate applicationDidFinishLaunching: nil] ;
    }) ;

    it(@"does not have a window", ^{
      expect(delegate.window).to.beNil() ;
    }) ;

    it(@"links the status menu", ^{
      expect(delegate.statusMenu).toNot.beNil() ;
    }) ;

    it(@"creates a status bar item", ^{
      expect(delegate.statusItem).toNot.beNil() ;
    }) ;
  }) ;

  describe(@"statusBarItem", ^{
    __weak NSStatusItem *statusItem ;
    
    beforeEach(^{
      [delegate applicationDidFinishLaunching: nil] ;
      statusItem = delegate.statusItem ;
    }) ;

    it(@"has the title 'CI'", ^{
      expect(statusItem.title).to.equal(@"CI") ;
    }) ;

    it(@"has the image 'statusIconTemplate'", ^{
      expect(statusItem.image.name).to.equal(@"statusIconTemplate") ;
    }) ;

    it(@"is in highlight mode", ^{
      expect(statusItem.highlightMode).to.beTruthy() ;
    }) ;

    it(@"is linked to the application status menu", ^{
      expect(statusItem.menu).to.beIdenticalTo(delegate.statusMenu) ;
    }) ;
  }) ;
});
SpecEnd