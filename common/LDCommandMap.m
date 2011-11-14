//
//  SupportedCommands.m
//  LDClient
//
//  Created by Ved Surtani on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LDCommandMap.h"

static NSMutableDictionary *commandsDictionary;
@implementation LDCommandMap
+(void)initialize
{
    commandsDictionary = [[NSMutableDictionary alloc] init];
}
+(void)setHandler:(id<LDCommandHandler>)handler forCommand:(NSString*)commandIdentifier info:(NSDictionary*)info
{
    NSDictionary *infoAndHandler = [NSDictionary dictionaryWithObjectsAndKeys:handler,@"handler",info,@"info", nil];
    [commandsDictionary setObject:infoAndHandler forKey:commandIdentifier];
}

+(id<LDCommandHandler>)handlerForCommand:(NSString*)commandIdentifier
{
    NSDictionary *infoAndHandler = [commandsDictionary objectForKey:commandIdentifier];
    if (infoAndHandler != nil) {
        return [infoAndHandler objectForKey:@"handler"];
    }
    return nil;
}
+(NSDictionary*)infoForCommand:(NSString*)commandIdentifier
{
    NSDictionary *infoAndHandler = [commandsDictionary objectForKey:commandIdentifier];
    if (infoAndHandler != nil) {
        return [infoAndHandler objectForKey:@"info"];
    }
    return nil;
}

@end
