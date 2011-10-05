//
//  EnumControlView.m
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

#import "EnumControlView.h"

@implementation EnumControlView
@synthesize optionsBox;
@synthesize options;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
-(void)dealloc
{
    [options release];
    [super dealloc];
}
-(void)awakeFromNib
{
    optionsBox.dataSource = self;
    optionsBox.delegate = self;
}


#pragma NSCombobox datasource and delegate
- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox
{
    if (options != nil) {
        return [options count];
    }
    return 0;
}
- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    return [options objectAtIndex:index];
    
    
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
    if (delegate != nil) {
        [delegate valueChanged:self];
    }

}
@end
