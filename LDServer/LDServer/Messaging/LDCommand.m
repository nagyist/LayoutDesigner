//
//  Command.m
//  LayoutModifier
//
//  Created by Ved Surtani on 24/08/11.
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

#import "LDCommand.h"


static NSInteger commandIdentifierSeed = 0;
static NSLock *identifierLock = nil;
static NSMutableArray *allCommands;


const static LDCommand *broadCastViewTree = nil;
const static LDCommand *highlightSelectedView = nil;
const static LDCommand *updateFrame = nil;
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
    updateFrame.identifier = 1001;
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

+(LDCommand*)broadcastViewTreeCommand
{
    return broadCastViewTree;
}
+(LDCommand*)highlightViewCommand
{
    return  highlightSelectedView;
}

+(LDCommand*)updateFrameCommand
{
    return updateFrame;
}

+(LDCommand*)updateBackgroundCommand
{
    return updateBackground;
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



-(void)dealloc
{
    [displayName release];
    [selectorName release];
    [super dealloc];
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
