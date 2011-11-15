//
//  LDConstants.h
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


extern  NSString * const ClientCommandSendCurrentViewTree;
extern  NSString * const ClientCommandSendViewUpdate;
extern  NSString * const ClientCommandHighlightView;
extern  NSString * const ClientCommandSetProperty;
extern  NSString * const ClientCommandSendMessage;

extern  NSString * const ServerCommandSelectView;
extern  NSString * const ServerCommandHandleViewUpdateResponse;
extern  NSString * const ServerCommandHandleCurrentViewTreeResponse;


extern  NSString * const NetworkPacketKeyCommand;
extern  NSString * const NetowrkPacketKeyData;
extern  NSString * const NetworkPacketDataKeyRootViewId;
extern  NSString * const NetworkPacketDataKeyViewId;

extern  NSString * const NetworkPacketDataKeyProperty;
extern  NSString * const NetworkPacketDataKetMessage;

@interface LDConstants : NSObject

@end
