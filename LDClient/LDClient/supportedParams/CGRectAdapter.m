//
//  LMMessageParamCGRect.m
//  LaMo
//
//  Created by Ved Surtani on 07/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
