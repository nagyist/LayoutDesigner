//
//  SupportedCommands.h
//  LDClient
//
//  Created by Ved Surtani on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LDCommandHandler;
@interface LDCommandMap : NSObject
{
}
+(void)setHandler:(id<LDCommandHandler>)handler forCommand:(NSString*)commandIdentifier info:(NSDictionary*)info; 
+(id<LDCommandHandler>)handlerForCommand:(NSString*)commandIdentifier;
+(NSDictionary*)infoForCommand:(NSString*)commandIdentifier;
@end



@protocol LDCommandHandler <NSObject>
@required
-(void)executeCommand:(NSString*)commandIdentifier withData:(NSDictionary*)packet commandInfo:(NSDictionary*)info;

@end