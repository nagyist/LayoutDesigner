//
//  LDClient.m
//  LDClient
//
//  Created by Ved Surtani on 05/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LDClient.h"
#import "ServerBrowser.h"
#import "ClientConnection.h"
#import "DefaultCommandHandler.h"
#import "LDCommandMap.h"
#import "LDConstants.h"
#import "LDView.h"

static LDClient *sharedInstance = nil;

@interface LDClient (Private)
-(void)findAndJoinServer; 
-(id)initPrivate;
-(void)initializeAndStart;
@end


@interface LDClient()
@property(nonatomic,strong)ClientConnection *client;
@end



@implementation LDClient
@synthesize client;

+(LDClient*)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[LDClient alloc] initPrivate];
    }
    return sharedInstance;
}
+(void)start
{
    [[LDClient sharedInstance]initializeAndStart];
}

- (id)init
{
    NSAssert(NO,@"Cannot instantiate directly, use sharedInstance");
    return self;
}

-(id)initPrivate
{
    self = [super init];
    return self;
}


-(void)initializeAndStart
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
    
    
    //start looking for server
    [self findAndJoinServer];
}

#pragma mark -
#pragma mark - ServerBrowser
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



#pragma mark -
#pragma mark - commands to client
-(void)sendCommand:(NSString*)commandId withData:(id)data
{
    NSMutableDictionary *packet = [[NSMutableDictionary alloc] init];
    [packet setObject:commandId forKey:NetworkPacketKeyCommand];
    [packet setObject:data forKey:NetowrkPacketKeyData];
    [client broadcastPacket:packet];
}

-(void)sendSelectViewCommand:(LDView*)selectedView inViewTree:(LDView*)treeRoot
{
    NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
    [data setObject:[NSString stringWithFormat:@"%d",selectedView.identifier] forKey:NetworkPacketDataKeyViewId];
    [data setObject:[NSString stringWithFormat:@"%d",treeRoot.identifier] forKey:NetworkPacketDataKeyRootViewId];
    // [client broadcastPacket:data];
    [self sendCommand:ServerCommandSelectView withData:data];
    
}



#pragma mark -
#pragma mark - ClientConnectionDelegate
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

@end
