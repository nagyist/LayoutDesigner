//
//  RemoteService.m
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

#import "RemoteService.h"
#import "LDMessage.h"

#import "LDMessageParam.h"
#import "LDProperty.h"
#import "DefaultCommandHandler.h"
#import "LDCommandMap.h"
#import "LDConstants.h"
#import "ViewTreeManager.h"

static RemoteService *sharedInstance = nil;
@implementation RemoteService
@synthesize client;
@synthesize root;
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
         [self setupClient];
        
       // [self replaceTouchHandler];
        [self findAndJoinServer];
       
    }
    
    return self;
}


-(void)setupClient
{
    //add client supported commands
    DefaultCommandHandler *defaultHandler = [[DefaultCommandHandler alloc] init];
    NSMutableDictionary *commandInfo = [[NSMutableDictionary alloc] init];
    
    [commandInfo setObject:@"sendCurrentViewTree:" forKey:@"selector"];                                 
    [LDCommandMap setHandler:defaultHandler forCommand:ClientCommandSendCurrentViewTree info:[commandInfo copy]];
    
    [commandInfo setObject:@"sendViewUpdate:" forKey:@"selector"];                                 
    [LDCommandMap setHandler:defaultHandler forCommand:ClientCommandSendViewUpdate info:[commandInfo copy]];
    
    [commandInfo setObject:@"highlightView:" forKey:@"selector"];                                 
    [LDCommandMap setHandler:defaultHandler forCommand:ClientCommandHighlightView info:[commandInfo copy]];
    
    [commandInfo setObject:@"setProperty:" forKey:@"selector"];                                 
    [LDCommandMap setHandler:defaultHandler forCommand:ClientCommandSetProperty info:[commandInfo copy]];
    
    [commandInfo setObject:@"sendMessage:" forKey:@"selector"];                                 
    [LDCommandMap setHandler:defaultHandler forCommand:ClientCommandSendMessage info:[commandInfo copy]];
     
    
    
    //give the developer a chance to do his own initialization
    //TODO:
}

-(void)sendCommand:(NSString*)commandId withData:(id)data
{
    NSMutableDictionary *packet = [[NSMutableDictionary alloc] init];
    [packet setObject:commandId forKey:NetworkPacketKeyCommand];
    [packet setObject:data forKey:NetowrkPacketKeyData];
    [client broadcastPacket:packet];
}
-(void)failedToConnect:(ClientConnection*)client_{
    self.client = nil;
    //attempt again
    [self findAndJoinServer];
}
-(void)connectionTerminated:(ClientConnection*)client_
{
    self.client = nil;
    //attempt again
    [self findAndJoinServer];
}
-(void)client:(ClientConnection*)client_ receivedNetworkPacket:(NSDictionary*)packet{
   
    NSString *commandId = [packet valueForKey:NetworkPacketKeyCommand];
    id<LDCommandHandler> handler = [LDCommandMap handlerForCommand:commandId];
    if (handler == nil) {
        NSLog(@"No handler found for command %@, packet %@",commandId,packet);
    }
    else
    {
        NSDictionary *commandInfo = [LDCommandMap infoForCommand:commandId];
        [handler executeCommand:commandId withData:packet commandInfo:commandInfo];
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
    
    self.client = [[ClientConnection alloc] initWithNetService:selectedServer];
    client.delegate = self;
    [client start];

    [serverBrowser stop];
    
    
}



-(void)sendSelectViewCommand:(LDView*)selectedView inViewTree:(LDView*)treeRoot
{
    NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
    [data setObject:[NSString stringWithFormat:@"%d",selectedView.identifier] forKey:NetworkPacketDataKeyViewId];
     [data setObject:[NSString stringWithFormat:@"%d",treeRoot.identifier] forKey:NetworkPacketDataKeyRootViewId];
   // [client broadcastPacket:data];
    [self sendCommand:ServerCommandSelectView withData:data];
    
}

@end
