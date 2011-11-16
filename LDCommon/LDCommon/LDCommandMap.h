//
//  LDCommandMap.h
//  LDClient
//
//  Created by Ved Surtani on 10/11/11.
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
@protocol LDCommandHandler;

/*!
 @class     LDCOmmandMap
 @brief     Map of commands and handlers (@ref LDCommandHandler)
 @details   A command is an action executed by LDClient on LDServer or by LDServer on LDClient. Commands are sent as string identifiers. This class 
 is a map that stores handlers for each string identifier. When a command is recenived from LDServer/LDClient an implementation of this map can provide 
 @ref LDCommandHandler instance that can handle the request.
 */
@interface LDCommandMap : NSObject
{
}

/*!
 @brief     adds the handler for specified commandIdentifier
 @param     handler instance implementing @ref LDCommandHandler protocol
 @param     commandIdentifier the string identifier for command
 @param     info extra information about the command, like which selector to call
 @details   calling this method will set the handler for the commandIdentifier for later retrieval. info can be used for passing extra information 
 when the command is received. For example selector can be added in info so the handler calls specific method when the command is received by it to handle.
 */
+(void)setHandler:(id<LDCommandHandler>)handler forCommand:(NSString*)commandIdentifier info:(NSDictionary*)info; 

/*!
 @brief     returns the handler for specified commandIdentifier
 @details   this method is used to retrieve the handler for received command. Once a command is received this handler can be used to execue specific 
 handler routine.
 */
+(id<LDCommandHandler>)handlerForCommand:(NSString*)commandIdentifier;

/*!
 @brief     returns the commandInfo for the specfied commandIdentifier
 @details   if additional information was provided while setting the handler, a non null dictionary is returned.
 */
+(NSDictionary*)infoForCommand:(NSString*)commandIdentifier;
@end


/*!
 @protocol      LDCommandHandler
 @brief         Protocol for commandHandlers to implement
 @details       Instances implementing this protocol can be used to register as handler for commands in @ref LDCommandMap
 */
@protocol LDCommandHandler <NSObject>
@required
/*!
 @brief     when a command is received, this method is called on the handler for executing handler code.
 @param     commandIdentifier string identifier of the command received
 @param     packet network packet that has required data with this command
 @param     info commandInformation if(any) that was stored with the handler
 @details   this method is called on the handler when a command is received and a handler is found for it in the @ref LDCommandMap
 */
-(void)executeCommand:(NSString*)commandIdentifier withData:(NSDictionary*)packet commandInfo:(NSDictionary*)info;

@end