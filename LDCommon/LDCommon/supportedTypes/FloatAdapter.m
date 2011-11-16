//
//  LMMessageParamFloat.m
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

#import "FloatAdapter.h"

@implementation FloatAdapter
@synthesize aFloat;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeFloat:aFloat forKey:@"float"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
   self =   [super init];
    self.aFloat= [aDecoder decodeFloatForKey:@"float"];
    return  self;
}


-(void*)value
{
    return &aFloat;
}

-(id)copyWithZone:(NSZone *)zone
{
    FloatAdapter  *copy = [[FloatAdapter alloc] init];
    copy.aFloat = aFloat;
    return copy;
}

#if TARGET_OS_IPHONE
#else
-(NSString*)getCode
{
    return [NSString stringWithFormat:@"%f",self.aFloat];
}
#endif
@end
