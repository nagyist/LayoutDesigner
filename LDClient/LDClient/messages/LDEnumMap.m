//
//  EnumMap.m
//  LDClient
//
//  Created by Ved Surtani on 03/11/11.
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

#import "EnumMap.h"
#import "EnumAdapter.h"

static inline NSString* stringValue(int val){
    return [NSString stringWithFormat:@"%d",val];
};

static EnumAdapter *textAlignment;

static NSMutableDictionary *enums;
@implementation EnumMap
+(void)initialize
{
    enums = [[NSMutableDictionary alloc] init];
    
    //create enums
    
    textAlignment = [[EnumAdapter alloc] init];
    textAlignment.displayNames = [NSArray arrayWithObjects:@"Left",@"Right",@"Center", nil];
    textAlignment.integerValuesAsString = [NSArray arrayWithObjects:stringValue(UITextAlignmentLeft),
                                           stringValue(UITextAlignmentRight),
                                           stringValue(UITextAlignmentCenter), nil];
    [enums setObject:textAlignment forKey:@"UITextAlignment"];
    
}

+(EnumAdapter*)enumForTextAlignment
{
    return [textAlignment copy];
}

+(void)addEnum:(EnumAdapter*)anEnum forKey:(NSString*)key
{
    [enums setObject:[anEnum copy] forKey:key];
}
+(EnumAdapter*)enumForKey:(NSString*)key
{
    return [[enums objectForKey:key] copy];
}
@end
