//
//  LMMessageParamColor.m
//  LaMo
//
//  Created by Ved Surtani on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIColorAdapter.h"


@implementation UIColorAdapter
@synthesize red,blue,green,alpha;
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
    [aCoder encodeFloat:red forKey:@"r"];
    [aCoder encodeFloat:green forKey:@"g"];
    [aCoder encodeFloat:blue forKey:@"b"];
    [aCoder encodeFloat:alpha forKey:@"a"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self =   [self init];
    self.red = [aDecoder decodeFloatForKey:@"r"];
    self.green = [aDecoder decodeFloatForKey:@"g"];
    self.blue = [aDecoder decodeFloatForKey:@"b"];
    self.alpha = [aDecoder decodeFloatForKey:@"a"];
    return  self;
}

-(void*)value
{
    color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return &color;
}


-(id)copyWithZone:(NSZone *)zone
{
    UIColorAdapter  *copy = [[UIColorAdapter alloc] init];
    copy.red = red;
    copy.green = green;
    copy.blue = blue;
    copy.alpha = alpha;
    return copy;
}

@end
