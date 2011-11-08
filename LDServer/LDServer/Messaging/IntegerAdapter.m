//
//  LMMessageParamInt.m
//  LaMo
//
//  Created by Ved Surtani on 07/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IntegerAdapter.h"

@implementation IntegerAdapter
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
   self =   [super init];
   self.integer =  [aDecoder decodeIntForKey:@"integer"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:self.integer  forKey:@"integer"];
}


-(void*)value
{
    return &integer;
}

-(id)copyWithZone:(NSZone *)zone
{
    IntegerAdapter  *copy = [[IntegerAdapter alloc] init];
    copy.integer = integer;
    return copy;
}

-(NSString*)getCode
{
    return [NSString stringWithFormat:@"%d",self.integer];
}
@end
