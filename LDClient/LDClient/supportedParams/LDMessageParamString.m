//
//  LMMessageParamString.m
//  LaMo
//
//  Created by Ved Surtani on 07/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LDMessageParamString.h"

@implementation LDMessageParamString
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
    self = [super initWithCoder:aDecoder];
    self.text = [aDecoder decodeObjectForKey:@"text"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.text forKey:@"text"];
}

-(void*)value
{
    return &text;
}
-(void)setValue:(void*)val
{
    text = (__bridge_transfer NSString*)val;
}

@end
