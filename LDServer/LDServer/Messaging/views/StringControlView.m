//
//  StringControlView.m
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

#import "StringControlView.h"
#import "NSStringAdapter.h"
@implementation StringControlView
@synthesize stringField;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.stringField.delegate = self;
    }
    
    return self;
}

- (IBAction)valueChanged:(id)sender {
    
    if (delegate != nil) {
        [delegate valueChanged:self];
    }
}
- (void)textDidChange:(NSNotification *)aNotification
{
    if (delegate != nil) {
        [delegate valueChanged:self];
    }
}


-(void)setInitialValue:(id<TypeAdapter>)initialValue
{
    NSParameterAssert([initialValue isKindOfClass:[NSString class]]);
    [stringField setTitleWithMnemonic:[(NSStringAdapter*)initialValue text]];
}

-(id<TypeAdapter>)getValue
{
    NSStringAdapter *value = [[NSStringAdapter alloc] init];
    value.text = [stringField stringValue];
    return [value autorelease];
}

@end
