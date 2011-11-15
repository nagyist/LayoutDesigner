//
//  DefaultCommandHandler.m
//  LDClient
//
//  Created by Ved Surtani on 10/11/11.
//  Copyright 2011 Imaginea 
//  Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at

//  http://www.apache.org/licenses/LICENSE-2.0

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "DefaultCommandHandler.h"
#import "RemoteService.h"
#import "LDConstants.h"
#import "ViewTreeManager.h"
#import "TreeUtil.h"
#import "LDProperty.h"
#import "LDMessage.h"
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
        DLog(@"Don't know how to handle command %@ commandInfo %@",commandIdentifier,info);
    }
}



-(void)sendCurrentViewTree:(NSDictionary*)packet
{
    LDView *currentVisibleViewTree = [[ViewTreeManager sharedInstance] createViewTreeForApplicationWindow];
    [[RemoteService sharedInstance] sendCommand:ServerCommandHandleCurrentViewTreeResponse withData:currentVisibleViewTree];
    
}
-(void)sendViewUpdate:(NSDictionary*)packet
{
    NSDictionary *data = [packet objectForKey:NetowrkPacketKeyData];
    NSInteger rootId = [[data valueForKey:NetworkPacketDataKeyRootViewId] intValue];
    LDView *root = [[ViewTreeManager sharedInstance] viewTreeForWithRootId:rootId];
    
    [[RemoteService sharedInstance] sendCommand:ServerCommandHandleViewUpdateResponse withData:root];
}



-(void)highlightView:(NSDictionary*)packet
{
    NSDictionary *data = [packet objectForKey:NetowrkPacketKeyData];
    NSInteger rootId = [[data valueForKey:NetworkPacketDataKeyRootViewId] intValue];
    NSInteger selectedViewId = [[data    valueForKey:NetworkPacketDataKeyViewId] intValue];
    LDView *root = [[ViewTreeManager sharedInstance] viewTreeForWithRootId:rootId];
    
    LDView *selectedViewNode = (LDView*)[TreeUtil findNode:selectedViewId inTreeRootedAt:root];
    
    if (selectedViewNode == nil || selectedViewNode.view == nil) {
        UIAlertView *alert = [[UIAlertView  alloc] initWithTitle:@"" message:@"No Matching View" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return; 
    }
    
    UIView *viewToBeUpdated = selectedViewNode.view;
    CGRect frame = viewToBeUpdated.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    UIView *highlightingView = [[UIView alloc] initWithFrame:frame];
    [highlightingView setBackgroundColor:[UIColor greenColor]];
    highlightingView.alpha = 0.4f;
    [viewToBeUpdated addSubview:highlightingView];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(removeHighligh:) userInfo:highlightingView repeats:NO];
}

-(void)setProperty:(NSDictionary*)packet
{
    NSDictionary *data = [packet objectForKey:NetowrkPacketKeyData];
    NSInteger rootId = [[data valueForKey:NetworkPacketDataKeyRootViewId] intValue];
    NSInteger selectedViewId = [[data    valueForKey:NetworkPacketDataKeyViewId] intValue];
    LDProperty *propertyToSet = [data objectForKey:NetworkPacketDataKeyProperty];
    
    LDView *root = [[ViewTreeManager sharedInstance] viewTreeForWithRootId:rootId];
    LDView *selectedViewNode = (LDView*)[TreeUtil findNode:selectedViewId inTreeRootedAt:root];
    
    if (selectedViewNode == nil || selectedViewNode.view == nil) {
        UIAlertView *alert = [[UIAlertView  alloc] initWithTitle:@"" message:@"No Matching View" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return; 
    }
    [propertyToSet setOnObject:selectedViewNode.view];

}
-(void)sendMessage:(NSDictionary*)packet
{
    DLog(@"Implement me!");
}

//private
-(void)removeHighligh:(id)timer
{
    UIView *view = (UIView*)[(NSTimer*)timer userInfo];
    [view removeFromSuperview];
}

@end
