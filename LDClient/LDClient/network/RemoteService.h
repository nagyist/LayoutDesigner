//
//  RemoteService.h
//  LayoutModifier
//
//  Created by Ved Surtani on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerBrowser.h"
#import "ServerBrowserDelegate.h"
#import "LDView.h"
#import "ClientConnection.h"
//#import "LDCommandMap.h"
//#import "LDConstants.h"
//#import "ViewTreeManager.h"

@interface RemoteService : NSObject<LMClientDelegate,ServerBrowserDelegate>{
    ServerBrowser *serverBrowser;
    ClientConnection *client;
    LDView *root;
    
    NSMutableArray *arrayOfSupportedCommands;
    
    
    BOOL hostReceivedCommands;

}
@property(readonly)LDView *root;
@property(nonatomic,strong)ClientConnection *client;
+(RemoteService*)sharedInstance;
-(void)sendCommand:(NSString*)commandId withData:(id)data;
-(void)findAndJoinServer;   
-(UIView*)viewForId:(NSInteger)anIdentifier inRoot:(LDView*)aRoot;
-(LDView*)treeNodeForView:(UIView*)aView searchInTree:(LDView*)rootNode;

-(LDView*)getTouchedViewIn:(LDView*)rootView sender:(UIGestureRecognizer*)sender;
-(BOOL)shouldGoInside:(UIView*)view;
-(void)sendSelectViewCommand:(LDView*)selectedView inViewTree:(LDView*)treeRoot;


//private methods for handling commands from server.
//TODO: move to private category
-(void)sendListOfCommands:(NSDictionary*)packet;
-(void)sendViewUpdate:(NSDictionary*)packet;
-(void)highlightSelectedView:(NSDictionary*)packet;
-(void)removeHighligh:(id)timer;
-(void)setupClient;
@end
