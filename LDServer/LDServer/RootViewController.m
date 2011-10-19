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
@implementation RootViewController
@synthesize tabView;

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
    MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
    
    Logger *logger = [Logger sharedInstance];
    
   NSTabViewItem *applicationViewItem =   [[tabView tabViewItems] objectAtIndex:0];
    [applicationViewItem setView:mainViewController.view];
    
    NSTabViewItem *logViewItem = [[tabView tabViewItems] objectAtIndex:1];
   // [logger.mViewController.view setBounds:[[logViewItem view] bounds]];
    [logViewItem setView:logger.mViewController.view];
}

@end
