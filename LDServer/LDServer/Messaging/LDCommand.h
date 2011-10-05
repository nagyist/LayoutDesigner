//
//  Command.h
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

#import <Foundation/Foundation.h>
static const int default_SendListOfCommands = 0;


@interface LDCommand : NSObject
{
    NSInteger identifier;
    NSString *displayName;
    NSString *selectorName;
    id target; // default is always RemoteService
}

@property(nonatomic,retain)NSString *displayName;
@property(nonatomic,retain)NSString *selectorName;
@property(nonatomic,assign)id target;
@property(nonatomic)NSInteger identifier;

+(LDCommand*)createNewCommandWithDisplayName:(NSString*)dName selectorName:(NSString*)sName target:(id)target;
-(BOOL)executeWithObject:(id)object_;
+(LDCommand*)commandWithIdentifier:(NSInteger)identifier_;
+(NSArray*)allCommands;


+(LDCommand*)broadcastViewTreeCommand;
+(LDCommand*)highlightViewCommand;
+(LDCommand*)updateFrameCommand;
+(LDCommand*)updateBackgroundCommand;
@end
