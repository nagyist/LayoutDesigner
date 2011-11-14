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
#import "DefaultCommandHandler.h"
#import "LDCommandMap.h"
#import "LDConstants.h"
@implementation LDAppDelegate

@synthesize window = _window;
@synthesize viewControllerForClientApplicationMainWindow;
- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    arrayOfMainViewControllers = [[NSMutableArray alloc] init];
    RootViewController *fvc = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
    [_window setContentView:fvc.view];
    
    self.viewControllerForClientApplicationMainWindow = fvc.viewControllerForClientMainScreen;//FIXIT:
    [arrayOfMainViewControllers addObject:viewControllerForClientApplicationMainWindow];
    [self setupServerApplication];

}

-(void)setupServerApplication
{
    //add supported server commands
    //add client supported commands
    DefaultCommandHandler *defaultHandler = [[DefaultCommandHandler alloc] init];
    NSMutableDictionary *commandInfo = [[NSMutableDictionary alloc] init];
    
    [commandInfo setObject:@"handleRefreshClientMainWindowView:" forKey:@"selector"];                                 
    [LDCommandMap setHandler:defaultHandler forCommand:ServerCommandHandleCurrentViewTreeResponse info:[[commandInfo copy] autorelease]];
    
    [commandInfo setObject:@"handleViewUpdateResponse:" forKey:@"selector"];                                 
    [LDCommandMap setHandler:defaultHandler forCommand:ServerCommandHandleViewUpdateResponse info:[[commandInfo copy] autorelease]];
    
    [commandInfo setObject:@"selectView:" forKey:@"selector"];                                 
    [LDCommandMap setHandler:defaultHandler forCommand:ServerCommandSelectView info:[[commandInfo copy] autorelease]];
    
}

-(MainViewController*)controllerForViewRoot:(NSInteger)identifier
{
    for(MainViewController *controller in arrayOfMainViewControllers)
    {
        if (controller.viewTreeRoot.identifier == identifier) {
            return controller;
        }
    }
    return nil;
}

@end
