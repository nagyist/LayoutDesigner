//
//  LMMessageParamEnum.m
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

#import "LDMessageParamEnum.h"
#import "EnumControlView.h"
@implementation LDMessageParamEnum
@synthesize displayNames,integerValuesAsString,selectedValue;
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
    [aCoder encodeObject:displayNames forKey:@"displayNames"];
    [aCoder encodeObject:integerValuesAsString  forKey:@"integerValues"];
    [aCoder encodeInt:selectedValue forKey:@"value"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self =   [super initWithCoder:aDecoder];
    self.displayNames = [aDecoder decodeObjectForKey:@"displayNames"];
    self.integerValuesAsString = [aDecoder decodeObjectForKey:@"integerValues"];
    self.selectedValue = [aDecoder decodeIntForKey:@"value"];

    return  self;
}

-(ControlView*)viewForCollectingData
{
    NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"EnumControl" bundle:nil];
    EnumControlView   *view = (EnumControlView*)viewController.view;
    view.options = self.displayNames;
    
  //  [view.optionsBox selectItemAtIndex:selectedValue];
     view.delegate = self;
    [viewController release];
    return view;
}


-(void)valueChanged:(ControlView *)view
{
    EnumControlView *mView = (EnumControlView*)view;
    int selectedIndex = [mView.optionsBox indexOfSelectedItem];
    self.selectedValue = [[integerValuesAsString objectAtIndex:selectedIndex] integerValue];
    
    if (delegate != nil) {
        [delegate valueChanged:self];
    }
}

-(void*)value
{
    return &selectedValue;
}


@end
