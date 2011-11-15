//
//  LMMessageParamEnum.m
//  LaMo
//
//  Created by Ved Surtani on 09/09/11.
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

#import "EnumAdapter.h"

@implementation EnumAdapter
@synthesize displayNames,integerValuesAsString,selectedValue;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:displayNames forKey:@"displayNames"];
    [aCoder encodeObject:integerValuesAsString  forKey:@"integerValues"];
    [aCoder encodeInt:selectedValue forKey:@"value"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self =   [super init];
    self.displayNames = [aDecoder decodeObjectForKey:@"displayNames"];
    self.integerValuesAsString = [aDecoder decodeObjectForKey:@"integerValues"];
    self.selectedValue = [aDecoder decodeIntForKey:@"value"];

    return  self;
}

-(void*)value
{
    return &selectedValue;
}

-(id)copyWithZone:(NSZone *)zone
{
    EnumAdapter  *copy = [[EnumAdapter alloc] init];
    copy.displayNames = displayNames;
    copy.integerValuesAsString = integerValuesAsString;
    copy.selectedValue = selectedValue;
    return copy;
}


@end
