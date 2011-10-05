//
//  LDAppDelegate.m
//  LDServer
//
//  Created by Ved Surtani on 05/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LDAppDelegate.h"
#import "LDRootViewController.h"
@implementation LDAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    LDRootViewController *fvc = [[LDRootViewController alloc] initWithNibName:@"LDRootViewController.nib" bundle:[NSBundle mainBundle]];
    [_window setContentView:fvc.view];
}

@end
