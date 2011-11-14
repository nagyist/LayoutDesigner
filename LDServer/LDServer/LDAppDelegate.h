//
//  LDAppDelegate.h
//  LDServer
//
//  Created by Ved Surtani on 05/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainViewController.h"
@interface LDAppDelegate : NSObject <NSApplicationDelegate>
{
    NSMutableArray *arrayOfMainViewControllers;
}

-(MainViewController*)controllerForViewRoot:(NSInteger)identifier;
@property (assign) IBOutlet NSWindow *window;
@property(nonatomic,strong)MainViewController *viewControllerForClientApplicationMainWindow;
@end
