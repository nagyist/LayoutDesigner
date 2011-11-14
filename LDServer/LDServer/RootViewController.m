//
//  MainViewController.m
//  LDServer
//
//  Created by Ved Surtani on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
#import "Logger.h"
#import "LDHost.h"
@implementation RootViewController
@synthesize tabView;
@synthesize viewControllerForClientMainScreen;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


-(void)loadView
{
    [super loadView];
    [[LDHost sharedInstance] start];
    
    MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
    viewControllerForClientMainScreen = mainViewController;
    Logger *logger = [Logger sharedInstance];
    
   NSTabViewItem *applicationViewItem =   [[tabView tabViewItems] objectAtIndex:0];
    [applicationViewItem setView:mainViewController.view];
    
    NSTabViewItem *logViewItem = [[tabView tabViewItems] objectAtIndex:1];
    [logViewItem setView:logger.mViewController.view];
}


@end
