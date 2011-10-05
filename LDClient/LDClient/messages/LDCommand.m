//
//  Command.m
//  LayoutModifier
//
//  Created by Ved Surtani on 24/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LDCommand.h"
#import "RemoteService.h"

static volatile NSInteger commandIdentifierSeed = 0;
static NSLock *identifierLock = nil;
static NSMutableArray *allCommands;



static LDCommand *broadCastViewTree = nil;
static LDCommand *highlightSelectedView = nil;
static LDCommand *updateFrame = nil;
static LDCommand *updateBackground = nil;

@implementation LDCommand

+(void)initialize
{
    commandIdentifierSeed = 999;
    identifierLock = [[NSLock alloc] init];
    allCommands = [[NSMutableArray alloc] init];
    
    
   broadCastViewTree =  [LDCommand createNewCommandWithDisplayName:@"Refresh" selectorName:@"sendViewUpdate:" target:nil];
  highlightSelectedView =   [LDCommand createNewCommandWithDisplayName:@"HiglightSelectedView" selectorName:@"highlightSelectedView:" target:nil];
  updateFrame =   [LDCommand createNewCommandWithDisplayName:@"updateFrame" selectorName:@"updateFrame:" target:nil];
    [LDCommand createNewCommandWithDisplayName:@""  selectorName:@"acknowledged:" target:nil];
    
    updateBackground = [LDCommand createNewCommandWithDisplayName:@"setBackground" selectorName:@"updateBackground:" target:nil];
    
    
}
@synthesize displayName,target,selectorName,identifier;


+(LDCommand*)createNewCommandWithDisplayName:(NSString*)dName selectorName:(NSString*)sName target:(id)target
{   
    LDCommand *aCommand = [[LDCommand alloc] init];
    aCommand.displayName = dName;
    aCommand.selectorName = sName;
    aCommand.target = target;
    [allCommands addObject:aCommand];
    return aCommand;
}

+(LDCommand*)commandWithIdentifier:(NSInteger)identifier_
{
    for(LDCommand *c in allCommands)
    {
        if (c.identifier == identifier_) {
            return c;
        }
    }
    
    if (identifier_ == default_SendListOfCommands) {
        return [LDCommand createNewCommandWithDisplayName:@"" selectorName:@"sendListOfCommands:" target:nil];
    }
    return  nil;
}

+(NSArray*)allCommands
{
    return [allCommands copy];
}

- (id)init
{
    self = [super init];
    if (self) {
        //synchronize, though not necessary for primitives but more code can be added.
        [identifierLock lock];
        identifier = commandIdentifierSeed++;
        [identifierLock unlock];
    }
    
    return self;
}





-(BOOL)executeWithObject:(id)object_
{
    SEL selector = NSSelectorFromString(selectorName);
    if (target == nil) {
        target = [RemoteService sharedInstance];
    }
    
    if ([target respondsToSelector:selector]) {
        [target performSelector:selector withObject:object_];
        return YES;
    }
    return NO;
}



-(BOOL)isEqual:(id)object
{
    if (object == nil) {
        return NO;
    }
    if (![object isKindOfClass:[LDCommand class]]) {
        return NO;
    }
    
    if ([(LDCommand*)object identifier] == identifier) {
        return YES;
    }
    return NO;
}

-(NSUInteger)hash
{
    return identifier;
}


@end
