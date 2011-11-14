//
//  LDConstants.h
//  LDClient
//
//  Created by Ved Surtani on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

////default commands
//NSString * const ClientCommandSendCurrentViewTree = @"ClientCommandSendCurrentViewTree";
//NSString * const ClientCommandSendViewUpdate = @"ClientCommandSendViewUpdate";
//NSString * const ClientCommandHighlightView = @"ClientCommandHighlightView";
//NSString * const ClientCommandSetProperty = @"ClientCommandSetProperty";
//NSString * const ClientCommandSendMessage = @"ClientCommandSendMessage";
//
//NSString * const ServerCommandHandleCurrentViewTreeResponse = @"ServerCommandHandleCurrentViewTreeResponse";
//NSString * const ServerCommandHandleViewUpdateResponse = @"ServerCommandHandleViewUpdateResponse";
//NSString * const ServerCommandSelectView = @"ServerCommandSelectView";
//
//
//NSString * const NetworkPacketKeyCommand = @"cmd";
//NSString * const NetowrkPacketKeyData = @"data";
//NSString * const NetworkPacketDataKeyRootViewId = @"rootId";
//NSString * const NetworkPacketDataKeyViewId = @"viewId";
//
//NSString *const NetworkPacketDataKeyProperty = @"property";
//NSString *const NetworkPacketDataKetMessage = @"message";

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
