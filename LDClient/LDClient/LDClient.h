//
//  LDClient.h
//  LDClient
//
//  Created by Ved Surtani on 05/10/11.
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


@class ServerBrowser;
@class ClientConnection;
@class LDView;
@protocol ClientConnectionDelegate;
@protocol ServerBrowserDelegate;
/*!
 @class     LDClient
 @brief     The entry point where the client is initialized and started. The sharedInstance of this class should be used by the iOS application to 
 interact with LDServer.
 @details   iOS applications using LDclient should call the start method after which client  does a series of initializations before the application 
 becomes visible to LDServer for interaction.
 */
@interface LDClient : NSObject<ClientConnectionDelegate,ServerBrowserDelegate>
{
    @private
    ServerBrowser *serverBrowser;
    ClientConnection *client;
    
}

/*!
 @brief     start the client.
 @details   this should be called only once per application launch. Only after this method returns the iOS application becomes visible to LDServer 
 for editing/designing.
 */
+(void)start;

/*!
 @brief     returns the singleton shared instance.
 */
+(LDClient*)sharedInstance;

/*!
 @brief     sends the command with specified commandId along with the data in the payload.
 @param     commandId string identifier of the command.
 @param     data the payload that goes along with command to the LDServer.
 @details   A packet is created with data and command. The keys for accessing items from this packet are found in @ref LDConstants. More items can be added 
 without the keys present in @ref LDConstants but LDServer should know how to retreive it and what to do with it.
 */
-(void)sendCommand:(NSString*)commandId withData:(id)data;  

/*!
 @brief     convenience method for sending a selectView command (@ref ServerCommandSelectView) to LDServer
 @param     selectedView the view that is to be selected
 @param     treeRoot the first view or the root view of the whole tree.
 @details   The call to this method will attempt to find the view on LDServer and select it there. This command is usually used for selecting a view for 
 editing by touching it on the iOS device/simulator.
 */
-(void)sendSelectViewCommand:(LDView*)selectedView inViewTree:(LDView*)treeRoot;


@end

