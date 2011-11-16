//
//  LDConstants.m
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

#import "LDConstants.h"
NSString * const ClientCommandSendCurrentViewTree = @"ClientCommandSendCurrentViewTree";
NSString * const ClientCommandSendViewUpdate = @"ClientCommandSendViewUpdate";
NSString * const ClientCommandHighlightView = @"ClientCommandHighlightView";
NSString * const ClientCommandSetProperty = @"ClientCommandSetProperty";
NSString * const ClientCommandSendMessage = @"ClientCommandSendMessage";

NSString * const ServerCommandHandleCurrentViewTreeResponse = @"ServerCommandHandleCurrentViewTreeResponse";
NSString * const ServerCommandHandleViewUpdateResponse = @"ServerCommandHandleViewUpdateResponse";
NSString * const ServerCommandSelectView = @"ServerCommandSelectView";


NSString * const NetworkPacketKeyCommand = @"cmd";
NSString * const NetowrkPacketKeyData = @"data";
NSString * const NetworkPacketDataKeyRootViewId = @"rootId";
NSString * const NetworkPacketDataKeyViewId = @"viewId";

NSString *const NetworkPacketDataKeyProperty = @"property";
NSString *const NetworkPacketDataKetMessage = @"message";



@implementation LDConstants

@end
