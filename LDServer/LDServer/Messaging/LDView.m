//
//  SubviewTree.m
//  LayoutModifier
//
//  Created by Ved Surtani on 17/08/11.
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

#import "LDView.h"
@implementation LDView
@synthesize identifier,frame,name,children,messages,properties;
- (id)init
{
    self = [super init];
    if (self) {
       
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeRect:frame forKey:@"frame"];
    [encoder encodeInt:(int)identifier forKey:@"id"];
    [encoder encodeObject:name forKey:@"name"];
    [encoder encodeObject:children forKey:@"children"];
    [encoder encodeObject:messages forKey:@"messages"];
     [encoder encodeObject:properties  forKey:@"properties"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    [self init];
    self.name =   [aDecoder decodeObjectForKey:@"name"];
    self.identifier = [aDecoder decodeIntForKey:@"id"];
    children = [aDecoder decodeObjectForKey:@"children"];
    if (children != nil) {
        [children retain];
    }
    
    float x = [aDecoder decodeFloatForKey:@"x"];
    float y = [aDecoder decodeFloatForKey:@"y"];
    float w = [aDecoder decodeFloatForKey:@"w"];
    float h = [aDecoder decodeFloatForKey:@"h"];
    frame = CGRectMake(x, y, w, h);
    self.messages = [aDecoder decodeObjectForKey:@"messages"];
    self.properties = [aDecoder decodeObjectForKey:@"properties"];
    return  self;
}


-(NSMutableDictionary*)toDictionary
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:self.name forKey:@"name"];
    [dictionary setObject:[NSString stringWithFormat:@"%d",self.identifier] forKey:@"id"];
    [dictionary setObject:[NSString stringWithFormat:@"%f",frame.origin.x] forKey:@"x"];
    [dictionary setObject:[NSString stringWithFormat:@"%f",frame.origin.y] forKey:@"y"];
    [dictionary setObject:[NSString stringWithFormat:@"%f",frame.size.width] forKey:@"width"];
    [dictionary setObject:[NSString stringWithFormat:@"%f",frame.size.height] forKey:@"height"];
    
    if (children != nil) {
        NSMutableArray *arrayOfChildDicts = [[NSMutableArray alloc] init];
        for(LDView *t in children){
            [arrayOfChildDicts addObject:[t toDictionary]];
        }
        [dictionary setObject:arrayOfChildDicts forKey:@"children"];
    }
    
    return  dictionary;
}




@end
