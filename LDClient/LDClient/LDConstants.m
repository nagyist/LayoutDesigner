//
//  LDConstants.m
//  LDClient
//
//  Created by Ved Surtani on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

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
