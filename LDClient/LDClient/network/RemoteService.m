//
//  RemoteService.m
//  LayoutModifier
//
//  Created by Ved Surtani on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RemoteService.h"
#import "LDMessage.h"
#import "LDCommand.h"
#import "LDMessageParam.h"
#import "LDProperty.h"


static RemoteService *sharedInstance = nil;
@implementation RemoteService
@synthesize client;
+(RemoteService*)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[RemoteService alloc] init];
    }
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
       // [self replaceTouchHandler];
        [self findAndJoinServer];
    }
    
    return self;
}


-(void)failedToConnect:(Client*)client_{
    self.client = nil;
    //attempt again
    [self findAndJoinServer];
}
-(void)connectionTerminated:(Client*)client_
{
    self.client = nil;
    //attempt again
    [self findAndJoinServer];
}
-(void)client:(Client*)client_ receivedNetworkPacket:(NSDictionary*)packet{
   
    id object = [packet objectForKey:@"exc"];
   
    if (object != nil) {
        if ([object isKindOfClass:[LDMessage class]]) {
             LDMessage *m = (LDMessage*)object;
            NSInteger viewId = [[packet objectForKey:@"id"] integerValue];
            UIView *viewToBeUpdated = [self viewForId:viewId inRoot:root];
            if (viewToBeUpdated != nil) {
                [m executeOnObject:viewToBeUpdated];
            }
            return;
        }
        else if([object isKindOfClass:[LDProperty class ]])
        {
            LDProperty *p = (LDProperty*)object;
            NSInteger viewId = [[packet objectForKey:@"id"] integerValue];
            UIView *viewToBeUpdated = [self viewForId:viewId inRoot:root];
            if (viewToBeUpdated != nil) {
                [p setOnObject:viewToBeUpdated];
            }
            return;
        }
    }
   
    NSInteger commandId =  [[packet objectForKey:@"cmd"] integerValue];
    LDCommand *cmd = [LDCommand commandWithIdentifier:commandId];
    if (cmd != nil) {
        [cmd executeWithObject:packet];
    }
}
-(void)findAndJoinServer
{
    if (serverBrowser != nil) {
        serverBrowser.delegate = nil;
        
    }
    serverBrowser = [[ServerBrowser alloc] init];
    serverBrowser.delegate = self;
    [serverBrowser start];
}

- (void)updateServerList
{
    NSNetService* selectedServer = [serverBrowser.servers objectAtIndex:0];
    
    self.client = [[Client alloc] initWithNetService:selectedServer];
    client.delegate = self;
    [client start];

    [serverBrowser stop];
    
    
}




-(UIView*)viewForId:(NSInteger)anIdentifier inRoot:(LDView*)aRoot
{
    if (aRoot.identifier == anIdentifier)
        return aRoot.view;
    else if(aRoot.children != nil){
      for(LDView *v in aRoot.children)
      {
          UIView *viewToBeReturned = [self viewForId:anIdentifier inRoot:v];
          if (viewToBeReturned != nil) {
              return viewToBeReturned;
          }
      }
    }
    return nil;
}

-(LDView*)treeNodeForView:(UIView*)aView searchInTree:(LDView*)rootNode
{
    if (rootNode == nil) {
        rootNode = root;
    }
    if (rootNode == nil) {
        return nil;
    }
    
    if (rootNode.view == aView) {
        return rootNode;
    }
    if (rootNode.children != nil) {
        for (LDView *t in rootNode.children) {
            LDView *treeNodeToReturn = [self treeNodeForView:aView searchInTree:t];
            if (treeNodeToReturn != nil) {
                return  treeNodeToReturn;
            }
        }
    }
    return nil;
    
}


//TODO: Remove Command inteface and deal with Messages only.
#pragma Commands
-(void)sendListOfCommands:(NSDictionary*)packet
{
    NSString *requestId = [packet objectForKey:@"requestid"];
    [client broadcastPacket:[NSDictionary dictionaryWithObject:[LDCommand allCommands] forKey:requestId]];
}

-(void)sendViewUpdate:(NSDictionary*)packet
{
    root = [[LDView alloc] init];
    id appDelegate  = [[UIApplication sharedApplication] delegate];
    root.view = [appDelegate window];
    [client broadcastPacket:[NSDictionary dictionaryWithObject:root forKey:@"data"]];
}


-(void)updateFrame:(NSDictionary*)packet
{
    NSInteger viewId = [[packet objectForKey:@"id"] integerValue];
    UIView *viewToBeUpdated = [self viewForId:viewId inRoot:root];
    
    if (viewToBeUpdated == nil) {
        UIAlertView *alert = [[UIAlertView  alloc] initWithTitle:@"" message:@"No Matching View" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return; 
    }
    
    CGRect frame = viewToBeUpdated.frame;
    NSString *xStr = [packet objectForKey:@"x"];
    NSString *yStr = [packet objectForKey:@"y"];
    NSString *wStr = [packet objectForKey:@"w"];
    NSString *hStr = [packet objectForKey:@"h"];
    
    if (xStr != nil && xStr.length >0) {
        frame.origin.x = [xStr floatValue];
    }
    if (yStr != nil && yStr.length >0) {
        frame.origin.y = [yStr floatValue];
    }
    if (wStr != nil && wStr.length >0) {
        frame.size.width = [wStr floatValue];
    }
    if (hStr != nil && hStr.length >0) {
        frame.size.height = [hStr floatValue];
    }
    viewToBeUpdated.frame = frame;
    [viewToBeUpdated setNeedsLayout];
}

-(void)highlightSelectedView:(NSDictionary*)packet
{
    NSInteger viewId = [[packet objectForKey:@"id"] integerValue];
    UIView *viewToBeUpdated = [self viewForId:viewId inRoot:root];
    if (viewToBeUpdated == nil) {
        UIAlertView *alert = [[UIAlertView  alloc] initWithTitle:@"" message:@"No Matching View" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return; 
    }
    CGRect frame = viewToBeUpdated.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    UIView *highlightingView = [[UIView alloc] initWithFrame:frame];
    [highlightingView setBackgroundColor:[UIColor greenColor]];
    highlightingView.alpha = 0.4f;
    [viewToBeUpdated addSubview:highlightingView];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(removeHighligh:) userInfo:highlightingView repeats:NO];
}


-(void)removeHighligh:(id)timer
{
    UIView *view = (UIView*)[(NSTimer*)timer userInfo];
    [view removeFromSuperview];
}






@end
