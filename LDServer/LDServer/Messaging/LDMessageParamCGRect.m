//
//  LMMessageParamCGRect.m
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

#import "LDMessageParamCGRect.h"

@implementation LDMessageParamCGRect
@synthesize rect;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    NSLog(@"Archiving");
    [super encodeWithCoder:encoder];
    [encoder encodeFloat:rect.origin.x forKey:@"x"];
    [encoder encodeFloat:rect.origin.y forKey:@"y"];
    [encoder encodeFloat:rect.size.width forKey:@"w"];
    [encoder encodeFloat:rect.size.height forKey:@"h"];
    NSLog(@"archived");
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
   
    float x = [aDecoder decodeFloatForKey:@"x"];
    float y = [aDecoder decodeFloatForKey:@"y"];
    float w = [aDecoder decodeFloatForKey:@"w"];
    float h = [aDecoder decodeFloatForKey:@"h"];
    self.rect = CGRectMake(x, y, w, h);
    return  self;
}


-(void*)value
{
    return &rect;
}

-(ControlView*)viewForCollectingData
{
    NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"FrameControl" bundle:nil];
    FrameControlView *view =(FrameControlView*) viewController.view;
    view.delegate = self;
    
    
    [view.xField setTitleWithMnemonic:[NSString stringWithFormat:@"%f",rect.origin.x]];
    [view.yField setTitleWithMnemonic:[NSString stringWithFormat:@"%f",rect.origin.y]];
    [view.wField setTitleWithMnemonic:[NSString stringWithFormat:@"%f",rect.size.width]];
    [view.hField setTitleWithMnemonic:[NSString stringWithFormat:@"%f",rect.size.height]];
    return view;
    
}
-(void)valueChanged:(ControlView *)view
{
    FrameControlView *mView = (FrameControlView*)view;
    CGFloat x = [mView.xField floatValue];
     CGFloat y = [mView.yField floatValue];
     CGFloat w = [mView.wField floatValue];
     CGFloat h = [mView.hField floatValue];
    
    self.rect = CGRectMake(x, y, w, h);
    
    if (delegate != nil) {
        [delegate valueChanged:self];
    }
}

@end
