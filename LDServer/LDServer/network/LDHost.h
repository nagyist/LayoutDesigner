//
//  LMHost.h
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

#import <Foundation/Foundation.h>
#import "Connection.h"
#import "Server.h"
#import "ServerDelegate.h"
#import "ConnectionDelegate.h"

@class LDProperty;
@protocol LMHostDelegate;

@interface LDHost : NSObject<ConnectionDelegate,ServerDelegate>
{
    // We accept connections from other clients using an instance of the Server class
    Server* server;
    
    // Container for all connected clients
    NSMutableSet* clients;
    
    id<LMHostDelegate> delegate;
}


@property(nonatomic,assign)id<LMHostDelegate> delegate;
+(LDHost*)sharedInstance;
- (BOOL)start;
- (void)stop;
-(void)broadcastPacket:(NSDictionary*)packet;
-(void)sendCommand:(NSString*)commandId withData:(NSDictionary*)data;
-(void)propertyChanged:(LDProperty*)property;
@end



@protocol LMHostDelegate <NSObject>

-(void)receivedNewPacket:(NSDictionary*)packet;

@end