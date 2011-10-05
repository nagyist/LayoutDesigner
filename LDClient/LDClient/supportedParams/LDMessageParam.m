//
//  LMMessageParam.m
//  LaMo
//
//  Created by Ved Surtani on 07/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LDMessageParam.h"

@implementation LDMessageParam
@synthesize displayName;
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
    self = [self init];
    
    self.displayName = [aDecoder decodeObjectForKey:@"displayName"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.displayName forKey:@"displayName"];
}



-(void*)value
{
    //TODO: throw exception
    return 0;
}

-(void)setValue:(void*)val
{
    
}

@end
