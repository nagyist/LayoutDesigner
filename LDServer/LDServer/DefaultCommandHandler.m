//
//  DefaultCommandHandler.m
//  LDServer
//
//  Created by Ved Surtani on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DefaultCommandHandler.h"
#import "LDView.h"
#import "MainViewController.h"
#import "LDConstants.h"
#import "LDAppDelegate.h"
#import "TreeUtil.h"
@implementation DefaultCommandHandler


#pragma 
#pragma LDCommandHandler delegate
-(void)executeCommand:(NSString*)commandIdentifier withData:(NSDictionary*)packet commandInfo:(NSDictionary*)info
{
    if ([info valueForKey:@"selector"] != nil) {
        SEL selectorToCall = NSSelectorFromString([info valueForKey:@"selector"]);
        if ([self respondsToSelector:selectorToCall]) {
            [self performSelector:selectorToCall withObject:packet];
        }
    }
    else
    {
        NSLog(@"Don't know how to handle command %@ commandInfo %@",commandIdentifier,info);
    }
}

-(void)handleViewUpdateResponse:(NSDictionary*)packet
{
    //TODO:
}

-(void)handleRefreshClientMainWindowView:(NSDictionary*)packet
{
    //this is to go in viewController handling applicationWindow
    LDView *viewTree = [packet objectForKey:NetowrkPacketKeyData];
    MainViewController *viewControllerForClientMainWindow = [(LDAppDelegate*)[[NSApplication sharedApplication]delegate] viewControllerForClientApplicationMainWindow];
    
    [viewControllerForClientMainWindow setViewTreeRoot:viewTree];
}

-(void)selectView:(NSDictionary*)packet
{
    NSDictionary *data = [packet objectForKey:NetowrkPacketKeyData];
    NSInteger selectedViewId = [[data objectForKey:NetworkPacketDataKeyViewId] intValue];
    NSInteger rootId = [[data objectForKey:NetworkPacketDataKeyRootViewId] intValue];
    
    MainViewController *controller = [(LDAppDelegate*)[[NSApplication sharedApplication] delegate]controllerForViewRoot:rootId];
    LDView *selectedView =   [TreeUtil findNode:selectedViewId inTreeRootedAt:controller.viewTreeRoot];
    [controller selectViewWithIdentifier:selectedView];
    
//    [controller ]
    
    
    
}



@end
