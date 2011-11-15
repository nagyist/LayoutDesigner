//
//  RemoteService.h
//  LayoutModifier
//
//  Created by Ved Surtani on 17/08/11.
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
//

#import <Foundation/Foundation.h>
#import "ServerBrowser.h"
#import "ServerBrowserDelegate.h"
#import "LDView.h"
#import "ClientConnection.h"

//TODO: delete this file
@interface RemoteService : NSObject<ClientConnectionDelegate,ServerBrowserDelegate>{
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

-(void)sendSelectViewCommand:(LDView*)selectedView inViewTree:(LDView*)treeRoot;


//private methods for handling commands from server.
//TODO: move to private category
-(void)setupClient;
@end
