//
//  LMMessageParamInt.m
//  LaMo
//
//  Created by Ved Surtani on 07/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LDMessageParamInt.h"

@implementation LDMessageParamInt
@synthesize integer;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
   self.integer =  [aDecoder decodeIntForKey:@"integer"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeInt:self.integer  forKey:@"integer"];
}


-(void*)value
{
    return &integer;
}

-(id)copy
{
    LDMessageParamInt  *copy = [[LDMessageParamInt alloc] init];
    copy.displayName = displayName;
    copy.integer = integer;
    return copy;
}
@end
