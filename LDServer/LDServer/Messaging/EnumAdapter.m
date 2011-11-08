//
//  LMMessageParamEnum.m
//  LaMo
//
//  Created by Ved Surtani on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EnumAdapter.h"

@implementation EnumAdapter
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
    
    [aCoder encodeObject:displayNames forKey:@"displayNames"];
    [aCoder encodeObject:integerValuesAsString  forKey:@"integerValues"];
    [aCoder encodeInt:selectedValue forKey:@"value"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self =   [super init];
    self.displayNames = [aDecoder decodeObjectForKey:@"displayNames"];
    self.integerValuesAsString = [aDecoder decodeObjectForKey:@"integerValues"];
    self.selectedValue = [aDecoder decodeIntForKey:@"value"];

    return  self;
}

-(void*)value
{
    return &selectedValue;
}

-(id)copyWithZone:(NSZone *)zone
{
    EnumAdapter  *copy = [[EnumAdapter alloc] init];
    copy.displayNames = displayNames;
    copy.integerValuesAsString = integerValuesAsString;
    copy.selectedValue = selectedValue;
    return copy;
}


-(NSString*)getCode
{
    return [NSString stringWithFormat:@"%d",self.selectedValue];
}

@end
