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
//

#import "LDView.h"
#import "LDMessage.h"
#import "LDPropertyMap.h"
//#import "TreeUtil.h"

static int viewId = 0;




@implementation LDView
@synthesize view,identifier,name,children,messages,properties;
- (id)init
{
    self = [super init];
    if (self) {
      
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt:identifier forKey:@"id"];
    [encoder encodeObject:name forKey:@"name"];
    [encoder encodeObject:children forKey:@"children"];
    [encoder encodeObject:messages forKey:@"messages"];
    [encoder encodeObject:properties  forKey:@"properties"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    self.name =   [aDecoder decodeObjectForKey:@"name"];
    self.identifier = [aDecoder decodeIntForKey:@"id"];
    children = [aDecoder decodeObjectForKey:@"children"];
    self.messages = [aDecoder decodeObjectForKey:@"messages"];
    self.properties = [aDecoder decodeObjectForKey:@"properties"];
    return  self;
}

-(void)setView:(UIView *)view_
{
    view = view_;
    self.name = [NSString stringWithFormat:@"%@",[view class]];
    self.identifier = viewId++;
    
    if ([view subviews] != nil ) {
        children = [[NSMutableArray alloc] init];
        for(UIView *sView in [view subviews])
        {
            LDView *childNode = [[LDView alloc] init];
            childNode.view = sView;
            [children addObject:childNode];
           
        }
    }
    self.messages = [[LDPropertyMap defaultPropertyMap] propertiesForObject:view_];
}

@end
