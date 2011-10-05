//
//  SubviewTree.m
//  LayoutModifier
//
//  Created by Ved Surtani on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LDView.h"
#import "LDMessage.h"
#import "LDMessageParamCGRect.h"
#import "MessageHelper.h"


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
    [encoder encodeFloat:frame.origin.x forKey:@"x"];
    [encoder encodeFloat:frame.origin.y forKey:@"y"];
    [encoder encodeFloat:frame.size.width forKey:@"w"];
    [encoder encodeFloat:frame.size.height forKey:@"h"];
    [encoder encodeObject:messages forKey:@"messages"];
    [encoder encodeObject:properties  forKey:@"properties"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    self.name =   [aDecoder decodeObjectForKey:@"name"];
    self.identifier = [aDecoder decodeIntForKey:@"id"];
    children = [aDecoder decodeObjectForKey:@"children"];
    
    float x = [aDecoder decodeFloatForKey:@"x"];
    float y = [aDecoder decodeFloatForKey:@"y"];
    float w = [aDecoder decodeFloatForKey:@"w"];
    float h = [aDecoder decodeFloatForKey:@"h"];
    frame = CGRectMake(x, y, w, h);
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
    
    self.messages = [MessageHelper messagesForObject:view_];
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
