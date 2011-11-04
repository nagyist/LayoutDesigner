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
#import "Client.h"
//#import "Command.h"

@interface RemoteService : NSObject<LMClientDelegate,ServerBrowserDelegate>{
    ServerBrowser *serverBrowser;
   // RemoteRoom *room;
    //NSMutableDictionary *dictionaryOfViews;
    Client *client;
    LDView *root;
    
    NSMutableArray *arrayOfSupportedCommands;
    
    
    BOOL hostReceivedCommands;

}
@property(nonatomic,strong)Client *client;
+(RemoteService*)sharedInstance;
-(void)findAndJoinServer;   
-(UIView*)viewForId:(NSInteger)anIdentifier inRoot:(LDView*)aRoot;
-(LDView*)treeNodeForView:(UIView*)aView searchInTree:(LDView*)rootNode;

-(LDView*)getTouchedViewIn:(LDView*)rootView sender:(UIGestureRecognizer*)sender;
-(BOOL)shouldGoInside:(UIView*)view;
-(void)sendSelectViewCommand:(LDView*)selectedView;


//private methods for handling commands from server.
//TODO: move to private category
-(void)sendListOfCommands:(NSDictionary*)packet;
-(void)sendViewUpdate:(NSDictionary*)packet;
-(void)updateFrame:(NSDictionary*)packet;
-(void)highlightSelectedView:(NSDictionary*)packet;
-(void)removeHighligh:(id)timer;
@end
