//
//  LMMessageParamImage.m
//  LaMo
//
//  Created by Ved Surtani on 12/09/11.
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
//

#import "UIImageAdapter.h"

@implementation UIImageAdapter
@synthesize imageData;
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
    [aCoder encodeDataObject:imageData];

}

-(id)initWithCoder:(NSCoder *)aDecoder
{
   self =   [super init];
    self.imageData = [aDecoder decodeDataObject];
    return  self;
}



-(void*)value
{
#if TARGET_OS_IPHONE
    image = [[UIImage alloc] initWithData:imageData];
#else
    image = [[NSImage alloc] initWithData:imageData];
#endif
    return &image;
}

-(id)copyWithZone:(NSZone *)zone
{
    UIImageAdapter  *copy = [[UIImageAdapter alloc] init];
    copy.imageData = imageData;
    return copy;
}

#if TARGET_OS_IPHONE
#else
-(NSString*)getCode
{
    return @"Not suppoerted YET!!";
}
#endif


@end
