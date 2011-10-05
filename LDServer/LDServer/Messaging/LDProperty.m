//
//  Property.m
//  LaMo
//
//  Created by Ved Surtani on 13/09/11.
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




#import "LDProperty.h"
#import "LDHost.h"
@implementation LDProperty
@synthesize name,getter,setter,param,selectedView;
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
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.getter = [aDecoder decodeObjectForKey:@"getter"];
    self.setter = [aDecoder decodeObjectForKey:@"setter"];
    self.param = [aDecoder decodeObjectForKey:@"param"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:getter forKey:@"getter"];
    [aCoder encodeObject:setter forKey:@"setter"];
    [aCoder encodeObject:param forKey:@"param"];
}

-(void)dealloc
{
    [name release];
    [setter  release];
    [getter release];
    [param release];
}

-(void)populateControls:(NSView*)viewToBeUpdated
{
    
    for(NSView *v in [viewToBeUpdated subviews])
    {
        if ([v isKindOfClass:[ControlView class]]) {
            [v removeFromSuperview];
        }
    }
    if (param != nil) {
        
        param.delegate = self;
        ControlView *aView = [param viewForCollectingData];
        [viewToBeUpdated addSubview:aView];
        
    }
}



-(void)valueChanged:(LDMessageParam*)param
{
    NSMutableDictionary *packet = [[NSMutableDictionary alloc] init];
    [packet setObject:[NSString stringWithFormat:@"%d",selectedView.identifier] forKey:@"id"];
    [packet setObject:self forKey:@"exc"];
    
    [[LDHost sharedInstance] broadcastPacket:packet];
}


@end
