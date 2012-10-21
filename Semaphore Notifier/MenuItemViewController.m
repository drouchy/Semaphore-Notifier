//
//  MenuItemViewController.m
//  Semaphore Notifier
//
//  Created by David Rouchy on 21/10/2012.
//  Copyright (c) 2012 David Rouchy. All rights reserved.
//

#import "MenuItemViewController.h"

@interface MenuItemViewController ()

@end

@implementation MenuItemViewController

@synthesize status = _status ;
@synthesize receivedData = _receivedData;
@synthesize menuItem = _menuItem;

- (NSMenuItem *) buildMenuItem {
  self.menuItem = [[NSMenuItem alloc] init] ;
  self.menuItem.view = self.view ;
  self.menuItem.submenu = [[NSMenu alloc] init] ;
  return self.menuItem ;
}

- (void) parseJson: (NSArray *) json {
}

#pragma mark NSURLConnection methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  NSLog(@"did receive response") ;
  self.receivedData = [[NSMutableData alloc] init];
  [self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  NSLog(@"did receive data") ;
  [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  NSLog(@"did fail with error") ;
  self.status = [NSNumber numberWithInt: ResourceStatusFailure] ;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  NSLog(@"did finish loading") ;
  self.status = [NSNumber numberWithInt: ResourceStatusSuccess] ;
  
  NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: self.receivedData options: NSJSONReadingMutableContainers error: nil];
  if(jsonArray) {
    [self parseJson: jsonArray] ;
  } else {
    self.status = [NSNumber numberWithInt: ResourceStatusFailure] ;
    NSLog(@"Failed to parse the response") ;
  }
}

@end
