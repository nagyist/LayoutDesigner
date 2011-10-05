//
//  LMMessageParamEnum.m
//  LaMo
//
//  Created by Ved Surtani on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LDMessageParamEnum.h"

@implementation LDMessageParamEnum
@synthesize displayNames,integerValuesAsString,selectedValue;
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
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:displayNames forKey:@"displayNames"];
    [aCoder encodeObject:integerValuesAsString  forKey:@"integerValues"];
    [aCoder encodeInt:selectedValue forKey:@"value"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self =   [super initWithCoder:aDecoder];
    self.displayNames = [aDecoder decodeObjectForKey:@"displayNames"];
    self.integerValuesAsString = [aDecoder decodeObjectForKey:@"integerValues"];
    self.selectedValue = [aDecoder decodeIntForKey:@"value"];

    return  self;
}

-(void*)value
{
    return &selectedValue;
}


@end
