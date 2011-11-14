//
//  SubviewTree.m
//  LayoutModifier
//
//  Created by Ved Surtani on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LDView.h"
#import "LDMessage.h"
#import "PropertyMap.h"
//#import "TreeUtil.h"

static int viewId = 0;




@implementation LDView
@synthesize view,identifier,frame,name,children,messages,properties;
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
    self.frame = view_.frame;
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
    self.messages = [[PropertyMap defaultPropertyMap] propertiesForObject:view_];
}

@end
