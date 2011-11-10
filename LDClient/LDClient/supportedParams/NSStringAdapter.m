//
//  LMMessageParamString.m
//  LaMo
//
//  Created by Ved Surtani on 07/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSStringAdapter.h"

@implementation NSStringAdapter
@synthesize text;

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
    self.text = [aDecoder decodeObjectForKey:@"text"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"text"];
}

-(void*)value
{
    return &text;
}

-(id)copyWithZone:(NSZone *)zone
{
    NSStringAdapter  *copy = [[NSStringAdapter alloc] init];
    copy.text  = text;
    return copy;
}
@end
