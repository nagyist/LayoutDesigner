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

#import "LDMessageParamColor.h"
#import "ColorControlView.h"
@implementation LDMessageParamColor
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
    [super encodeWithCoder:aCoder];
    [aCoder encodeFloat:red forKey:@"r"];
    [aCoder encodeFloat:green forKey:@"g"];
    [aCoder encodeFloat:blue forKey:@"b"];
    [aCoder encodeFloat:alpha forKey:@"a"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
  self =   [super initWithCoder:aDecoder];
    self.red = [aDecoder decodeFloatForKey:@"r"];
    self.green = [aDecoder decodeFloatForKey:@"g"];
    self.blue = [aDecoder decodeFloatForKey:@"b"];
    self.alpha = [aDecoder decodeFloatForKey:@"a"];
    return  self;
}



-(ControlView*)viewForCollectingData
{
    NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"ColorControl" bundle:nil];
    ColorControlView   *view = (ColorControlView*)viewController.view;
    view.delegate = self;
    
    NSColor *existingColor = [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha];
    [view.colorWell setColor:existingColor];
    [viewController release];
    return view;
}

-(void)valueChanged:(ControlView *)view
{
    ColorControlView *mView = (ColorControlView*)view;
    NSColor *color = [mView.colorWell color];
    self.red = [color redComponent];
    self.green = [color greenComponent];
    self.blue   = [color blueComponent];
    self.alpha = [color alphaComponent];
    
    if (delegate != nil) {
        [delegate valueChanged:self];
    }
}
-(NSString*)getCode{
    return [NSString stringWithFormat:@"[UIColor colorWithRed:%f green:%f blue:%f alpha:%f]",self.red,self.green,self.blue,self.alpha];
}



@end
