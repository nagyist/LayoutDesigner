//
//  ColorControlView.m
//  MacApplicationTest
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

#import "UIColorInputView.h"
#import "UIColorAdapter.h"
@implementation UIColorInputView
@synthesize colorWell;
@synthesize delegate;
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


-(void)awakeFromNib
{
    [colorWell setTarget:self];
    [colorWell setAction:@selector(colorPickerValueChanged:)];
}

-(void)colorPickerValueChanged:(id)sender
{
    if (delegate != nil) {
        [delegate valueChanged:self];
    }
}


#pragma mark -
#pragma InputView protocol
-(void)setInitialValue:(id<TypeAdapter>)initialValue
{
    NSParameterAssert([initialValue isKindOfClass:[UIColorAdapter class]]);
    UIColorAdapter *initialColor = (UIColorAdapter*)initialValue;
    NSColor *color = [NSColor colorWithDeviceRed:initialColor.red green:initialColor.green blue:initialColor.blue alpha:initialColor.alpha];
    [colorWell setColor:color];
}

-(id<TypeAdapter>)getValue
{
    UIColorAdapter *color = [[UIColorAdapter alloc] init];
    color.red = [colorWell.color redComponent];
    color.blue = [colorWell.color blueComponent];
    color.green = [colorWell.color greenComponent];
    color.alpha = [colorWell.color alphaComponent];
    return [color autorelease];
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

@end
