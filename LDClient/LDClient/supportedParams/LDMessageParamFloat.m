//
//  LMMessageParamFloat.m
//  LaMo
//
//  Created by Ved Surtani on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LDMessageParamFloat.h"

@implementation LDMessageParamFloat
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
    [super encodeWithCoder:encoder];
    [encoder encodeFloat:aFloat forKey:@"float"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.aFloat= [aDecoder decodeFloatForKey:@"float"];
    return  self;
}


-(void*)value
{
    return &aFloat;
}

-(id)copy
{
    LDMessageParamFloat  *copy = [[LDMessageParamFloat alloc] init];
    copy.displayName = displayName;
    copy.aFloat = aFloat;
    return copy;
}
@end
