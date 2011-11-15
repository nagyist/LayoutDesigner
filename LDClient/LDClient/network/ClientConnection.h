//
//  LMClient.h
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

#import <Foundation/Foundation.h>

#import "ConnectionDelegate.h"
#import "Connection.h"


@protocol ClientConnectionDelegate;


@interface ClientConnection : NSObject<ConnectionDelegate>{
// Our connection to the chat server
    Connection* connection;
    
    
    id<ClientConnectionDelegate> __weak delegate;
}


@property(nonatomic,weak)id<ClientConnectionDelegate> delegate;
// Initialize with host address and port
- (id)initWithHost:(NSString*)host andPort:(int)port;

// Initialize with a reference to a net service discovered via Bonjour
- (id)initWithNetService:(NSNetService*)netService;

-(void)broadcastPacket:(NSDictionary*)packet;
-(BOOL)start;
@end



@protocol ClientConnectionDelegate <NSObject>

-(void)failedToConnect:(ClientConnection*)client_;
-(void)connectionTerminated:(ClientConnection*)client_;
-(void)client:(ClientConnection*)client_ receivedNetworkPacket:(NSDictionary*)packet;
@end