//
//  LMClient.h
//  LayoutModifier
//
//  Created by Ved Surtani on 24/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ConnectionDelegate.h"
#import "Connection.h"


@protocol LMClientDelegate;


@interface ClientConnection : NSObject<ConnectionDelegate>{
// Our connection to the chat server
    Connection* connection;
    
    
    id<LMClientDelegate> __weak delegate;
}


@property(nonatomic,weak)id<LMClientDelegate> delegate;
// Initialize with host address and port
- (id)initWithHost:(NSString*)host andPort:(int)port;

// Initialize with a reference to a net service discovered via Bonjour
- (id)initWithNetService:(NSNetService*)netService;

-(void)broadcastPacket:(NSDictionary*)packet;
-(BOOL)start;
@end



@protocol LMClientDelegate <NSObject>

-(void)failedToConnect:(ClientConnection*)client_;
-(void)connectionTerminated:(ClientConnection*)client_;
-(void)client:(ClientConnection*)client_ receivedNetworkPacket:(NSDictionary*)packet;
@end