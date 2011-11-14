//
//  LMHost.m
//  LayoutModifier
//
//  Created by Ved Surtani on 24/08/11.
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


#import "LDHost.h"
#import "LDCommand.h"
#import "LDConstants.h"
#import "LDCommandMap.h"
#import "LDProperty.h"

static inline NSString* stringValue(long val){
    return [NSString stringWithFormat:@"%d",val];
}

// Private properties
@interface LDHost ()
@property(nonatomic,retain) Server* server;
@property(nonatomic,retain) NSMutableSet* clients;
@end



static LDHost *sharedInstance = nil;

@implementation LDHost
@synthesize server, clients;
@synthesize delegate;



+(LDHost*)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[LDHost alloc] init];
    }
    return  sharedInstance;
}
// Initialization
- (id)init {
    clients = [[NSMutableSet alloc] init];
    
    return self;
}


// Cleanup
- (void)dealloc {
    self.clients = nil;
    self.server = nil;
    [super dealloc];
}


// Start the server and announce self
- (BOOL)start {
    // Create new instance of the server and start it up
    server = [[Server alloc] init];
    
    // We will be processing server events
    server.delegate = self;
    
    // Try to start it up
    if ( ! [server start] ) {
        self.server = nil;
        return NO;
    }
    
    return YES;
}


// Stop everything
- (void)stop {
    // Destroy server
    [server stop];
    self.server = nil;
    
    // Close all connections
    [clients makeObjectsPerformSelector:@selector(close)];
}


// Send chat message to all connected clients
- (void)broadcastPacket:(NSDictionary *)packet {    
    // Send it out
    [clients makeObjectsPerformSelector:@selector(sendNetworkPacket:) withObject:packet];
}


#pragma mark -
#pragma mark ServerDelegate Method Implementations

// Server has failed. Stop the world.
- (void) serverFailed:(Server*)server reason:(NSString*)reason {
    // Stop everything and let our delegate know
    [self stop];
   // [delegate roomTerminated:self reason:reason];
}


// New client connected to our server. Add it.
- (void) handleNewConnection:(Connection*)connection {
    // Delegate everything to us
    connection.delegate = self;
    NSLog(@"New Connection ");
    // Add to our list of clients
    [clients addObject:connection];
}


#pragma mark -
#pragma mark ConnectionDelegate Method Implementations

// We won't be initiating connections, so this is not important
- (void) connectionAttemptFailed:(Connection*)connection {
}


// One of the clients disconnected, remove it from our list
- (void) connectionTerminated:(Connection*)connection {
    [clients removeObject:connection];
}


// One of connected clients sent a chat message. Propagate it further.
- (void) receivedNetworkPacket:(NSDictionary*)packet viaConnection:(Connection*)connection {
    NSLog(@"received newtwork packet");
    
    NSString *commandId = [packet valueForKey:NetworkPacketKeyCommand];
    id<LDCommandHandler> handler = [LDCommandMap handlerForCommand:commandId];
    if (handler != nil) {
        NSDictionary *commandInfo = [LDCommandMap infoForCommand:commandId];
        [handler executeCommand:commandId withData:packet commandInfo:commandInfo];
    }
}

-(void)sendCommand:(NSString*)commandId withData:(NSDictionary*)data
{
    NSMutableDictionary *packet = [[NSMutableDictionary alloc] init];
    [packet setObject:commandId forKey:NetworkPacketKeyCommand];
    [packet setObject:data forKey:NetowrkPacketKeyData];
    [self broadcastPacket:packet];
}

-(void)propertyChanged:(LDProperty*)property
{
    if(property.selectedView == nil || property.viewTreeRoot == nil)
    {
        NSLog(@"Error sending property change to client, viewTreeRoot or selectedView is nil, selectedView %@  viewTreeRoot %@ ",property.selectedView,property.viewTreeRoot);
        return;
    }
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:property forKey:NetworkPacketDataKeyProperty];
    [data setObject:stringValue([property.selectedView identifier]) forKey:NetworkPacketDataKeyViewId];
    [data setObject:stringValue(property.viewTreeRoot.identifier) forKey:NetworkPacketDataKeyRootViewId];
    [self sendCommand:ClientCommandSetProperty withData:data];
    [data release];
}
@end
