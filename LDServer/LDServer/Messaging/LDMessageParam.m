//
//  LMMessageParam.m
//  LaMo
//
//  Created by Ved Surtani on 07/09/11.
//  Copyright 2011 Imaginea 
//  Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at

//  http://www.apache.org/licenses/LICENSE-2.0

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "LDMessageParam.h"
@implementation LDMessageParam
@synthesize displayName,delegate;
@synthesize value;
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
    [self init];
    
    self.displayName = [aDecoder decodeObjectForKey:@"displayName"];
    self.value = [aDecoder decodeObjectForKey:@"value"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.displayName forKey:@"displayName"];
    [aCoder encodeObject:self.value forKey:@"value"];
}


-(void)dealloc
{
    [displayName release];
    [super dealloc];
}

-(void*)getValue;
{
    return [value value];
}

-(void)valueChanged:(LDMessageParam *)param
{
    if (delegate != nil) {
        [delegate valueChanged:self];
    }
    else{
        [self sendUpdate];
    }
}


-(void)sendUpdate
{
    
}

-(NSString*)getCode{
    return @"Not implemented by the parameter!!!";
}

-(id)copyWithZone:(NSZone *)zone
{
    LDMessageParam *copy = [[LDMessageParam alloc] init];
    copy.displayName = displayName;
    copy.value = [value copyWithZone:nil];
    return copy;
}
@end
