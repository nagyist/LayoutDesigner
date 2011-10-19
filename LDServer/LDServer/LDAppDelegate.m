//
//  LDAppDelegate.m
//  LDServer
//
//  Created by Ved Surtani on 05/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LDAppDelegate.h"

#import "Logger.h"
#import "RootViewController.h"
@implementation LDAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    RootViewController *fvc = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
    
    [_window setContentView:fvc.view];

}

@end
