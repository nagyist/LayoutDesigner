//
//  LMMessageParamCGRect.m
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

#import "CGRectAdapter.h"

@implementation CGRectAdapter
@synthesize rect;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.rect = CGRectMake(0, 0, 0, 0);
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    
    [encoder encodeFloat:rect.origin.x forKey:@"x"];
    [encoder encodeFloat:rect.origin.y forKey:@"y"];
    [encoder encodeFloat:rect.size.width forKey:@"w"];
    [encoder encodeFloat:rect.size.height forKey:@"h"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self =   [super init];
   
    float x = [aDecoder decodeFloatForKey:@"x"];
    float y = [aDecoder decodeFloatForKey:@"y"];
    float w = [aDecoder decodeFloatForKey:@"w"];
    float h = [aDecoder decodeFloatForKey:@"h"];
    self.rect = CGRectMake(x, y, w, h);
    return  self;
}


-(void*)value
{
    return &rect;
}

-(id)copyWithZone:(NSZone *)zone
{
    CGRectAdapter  *copy = [[CGRectAdapter alloc] init];
    copy.rect = rect;
    return copy;
}

@end
