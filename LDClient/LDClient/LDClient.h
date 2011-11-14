//
//  LDClient.h
//  LDClient
//
//  Created by Ved Surtani on 05/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ServerBrowser;
@class ClientConnection;
@class LDView;
@protocol ClientConnectionDelegate;
@protocol ServerBrowserDelegate;
@interface LDClient : NSObject<ClientConnectionDelegate,ServerBrowserDelegate>
{
    @private
    ServerBrowser *serverBrowser;
    ClientConnection *client;
    
}

+(void)start;
+(LDClient*)sharedInstance;
-(void)sendCommand:(NSString*)commandId withData:(id)data;  
-(void)sendSelectViewCommand:(LDView*)selectedView inViewTree:(LDView*)treeRoot;


@end

