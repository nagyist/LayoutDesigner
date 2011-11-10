//
//  LMMessageParam.m
//  LaMo
//
//  Created by Ved Surtani on 07/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LDMessageParam.h"

@implementation LDMessageParam
@synthesize displayName,value;



+(LDMessageParam*)paramWithValue:(id<TypeAdapter>)typeAdapter
{
    LDMessageParam *messageParam = [[LDMessageParam alloc] init];
    messageParam.value = typeAdapter;
    return messageParam;
}
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
    self.value = [aDecoder decodeObjectForKey:@"value"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.displayName forKey:@"displayName"];
    [aCoder encodeObject:self.value forKey:@"value"];
}



-(void*)getValue
{
    return [value value];
}

-(id)copyWithZone:(NSZone *)zone
{
    LDMessageParam  *copy = [[LDMessageParam alloc] init];
    copy.displayName = displayName;
    copy.value = [value copyWithZone:nil];
    return copy;
}

@end
