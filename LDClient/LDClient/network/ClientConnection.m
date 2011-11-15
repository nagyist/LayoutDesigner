//
//  LMClient.m
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
//




#import "ClientConnection.h"


// Private properties
@interface ClientConnection ()
@property(nonatomic,strong) Connection* connection;
@end




@implementation ClientConnection
@synthesize connection;
@synthesize delegate;
// Setup connection but don't connect yet
- (id)initWithHost:(NSString*)host andPort:(int)port {
    connection = [[Connection alloc] initWithHostAddress:host andPort:port];
    return self;
}


// Initialize and connect to a net service
- (id)initWithNetService:(NSNetService*)netService {
    connection = [[Connection alloc] initWithNetService:netService];
    return self;
}



// Start everything up, connect to server
- (BOOL)start {
    if ( connection == nil ) {
        return NO;
    }
    
    // We are the delegate
    connection.delegate = self;
    
    return [connection connect];
}


// Stop everything, disconnect from server
- (void)stop {
    if ( connection == nil ) {
        return;
    }
    
    [connection close];
    self.connection = nil;
}


-(void)broadcastPacket:(NSDictionary*)packet
{
    [connection sendNetworkPacket:packet];
}


#pragma mark -
#pragma mark ConnectionDelegate Method Implementations

- (void)connectionAttemptFailed:(Connection*)connection {
    [delegate failedToConnect:self];
    
}


- (void)connectionTerminated:(Connection*)connection {
   // [delegate roomTerminated:self reason:@"Connection to server closed"];
    [delegate connectionTerminated:self];
}


- (void)receivedNetworkPacket:(NSDictionary*)packet viaConnection:(Connection*)connection {
    [delegate client:self receivedNetworkPacket:packet];
}

@end
