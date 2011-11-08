//
//  LMMessageParamFloat.m
//  LaMo
//
//  Created by Ved Surtani on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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

-(NSString*)getCode
{
    return [NSString stringWithFormat:@"%f",self.aFloat];
}
@end
