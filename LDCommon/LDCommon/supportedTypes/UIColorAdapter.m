//
//  LMMessageParamColor.m
//  LaMo
//
//  Created by Ved Surtani on 09/09/11.
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

#import "UIColorAdapter.h"


@implementation UIColorAdapter
@synthesize red,blue,green,alpha;
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
    [aCoder encodeFloat:red forKey:@"r"];
    [aCoder encodeFloat:green forKey:@"g"];
    [aCoder encodeFloat:blue forKey:@"b"];
    [aCoder encodeFloat:alpha forKey:@"a"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self =   [self init];
    self.red = [aDecoder decodeFloatForKey:@"r"];
    self.green = [aDecoder decodeFloatForKey:@"g"];
    self.blue = [aDecoder decodeFloatForKey:@"b"];
    self.alpha = [aDecoder decodeFloatForKey:@"a"];
    return  self;
}

-(void*)value
{
#if TARGET_OS_IPHONE
        color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
#else
    color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
#endif
    return &color;
}


-(id)copyWithZone:(NSZone *)zone
{
    UIColorAdapter  *copy = [[UIColorAdapter alloc] init];
    copy.red = red;
    copy.green = green;
    copy.blue = blue;
    copy.alpha = alpha;
    return copy;
}

#if TARGET_OS_IPHONE
#else
-(NSString*)getCode{
    return [NSString stringWithFormat:@"[UIColor colorWithRed:%f green:%f blue:%f alpha:%f]",self.red,self.green,self.blue,self.alpha];
}
#endif

@end
