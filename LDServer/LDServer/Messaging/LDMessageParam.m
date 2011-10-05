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
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.displayName forKey:@"displayName"];
}


-(void)dealloc
{
    [displayName release];
    [super dealloc];
}

-(void*)value
{
    //TODO: throw exception
    return 0;
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

-(ControlView*)viewForCollectingData
{
    return nil;
}

-(void)sendUpdate
{
    
}
@end
