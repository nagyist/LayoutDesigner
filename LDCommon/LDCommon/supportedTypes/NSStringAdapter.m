//
//  LMMessageParamString.m
//  LaMo
//
//  Created by Ved Surtani on 07/09/11.
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

#import "NSStringAdapter.h"

@implementation NSStringAdapter
@synthesize text;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
   self =   [super init];
    self.text = [aDecoder decodeObjectForKey:@"text"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"text"];
}

-(void*)value
{
    return &text;
}

-(id)copyWithZone:(NSZone *)zone
{
    NSStringAdapter  *copy = [[NSStringAdapter alloc] init];
    copy.text  = text;
    return copy;
}

#if TARGET_OS_IPHONE
#else
-(NSString*)getCode
{
    if (text!= nil) {
        return [NSString stringWithFormat:@"@\"%@\"",self.text];
    }
    return @"nil";
    
}
#endif
@end
