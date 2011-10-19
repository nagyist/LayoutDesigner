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

#import "LDMessageParamImage.h"
#import "ImageControlView.h"
@implementation LDMessageParamImage
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
    [super encodeWithCoder:aCoder];
    [aCoder encodeDataObject:self.imageData];

}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self =   [super initWithCoder:aDecoder];
    self.imageData =     [aDecoder decodeDataObject];
    return  self;
}
-(void)dealloc
{
    [imageData release];
    [super dealloc];
}


-(ControlView*)viewForCollectingData
{
    NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"ImageControl" bundle:nil];
    ImageControlView   *view = (ImageControlView*)viewController.view;
    
    if (imageData != nil) {
        view.imageView.image = [[NSImage alloc] initWithData:imageData];
    }

    view.delegate = self;
    [viewController release];
    return view;
}


-(void)valueChanged:(ControlView *)view
{
    ImageControlView *mView = (ImageControlView*)view;
  NSImage *selectedImage =   mView.imageView.image;
    if (selectedImage != nil) {
        NSData *data = [selectedImage TIFFRepresentation];
        if (data != nil) {
            self.imageData = data;
        }
    }
    
    if (delegate != nil && self.imageData != nil) {
        [delegate valueChanged:self];
    }
}

//TODO: add support!!!
-(NSString*)getCode
{
    return @"Not suppoerted YET!!";
}



@end
