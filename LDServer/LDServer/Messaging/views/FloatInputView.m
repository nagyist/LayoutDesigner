//
//  FloatControlView.m
//  MacApplicationTest
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

#import "FloatInputView.h"
#import "FloatAdapter.h"
@implementation FloatInputView
@synthesize floatField;
@synthesize delegate;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (IBAction)valueChanged:(id)sender {
    if (delegate != nil) {
        [delegate valueChanged:self];
    }
}

#pragma mark -
#pragma InputView protocol
-(void)setInitialValue:(id<TypeAdapter>)initialValue
{
    NSParameterAssert([initialValue isKindOfClass:[FloatAdapter class]]);
    [floatField setFloatValue:[(FloatAdapter*)initialValue aFloat]];

}

-(id<TypeAdapter>)getValue
{
    FloatAdapter *value = [[FloatAdapter alloc] init];
    [value setAFloat:[floatField floatValue]];
    return [value autorelease];
}

@end
