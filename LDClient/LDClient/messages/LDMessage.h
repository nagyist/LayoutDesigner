//
//  Message.h
//  LaMo
//
//  Created by Ved Surtani on 05/09/11.
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
//

#import <Foundation/Foundation.h>

//TODO: this is to be edited.
@interface LDMessage : NSObject<NSCoding>

{
    NSString *displayName;
    NSString *selectorAsString;
    NSArray *params;
}
@property(nonatomic,strong)NSString *displayName;
@property(nonatomic,strong)NSString *selectorAsString;
@property(nonatomic,strong)NSArray *params;


+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s params:(NSArray*)params;
+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s param:(id)param;
+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s param:(id)param param:(id)p2;


-(void)executeOnObject:(id)object;
-(void)executeOnObject:(id)object returnVal:(void*)returnVal;
-(NSInvocation*)invocationForObject:(id)object;

@end
