//
//  ControlView.h
//  MacApplicationTest
//
//  Created by Ved Surtani on 08/09/11.
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

#import <Cocoa/Cocoa.h>
#import "TypeAdapter.h"
@protocol InputViewDelegate;

@protocol InputView <NSObject>
@property (weak) id<InputViewDelegate> delegate;
@required
-(void)setInitialValue:(id<TypeAdapter>)initialValue;
-(id<TypeAdapter>)getValue;
@optional
-(void)setup;
-(void)cleanup;
@end





@protocol InputViewDelegate <NSObject>
-(void)valueChanged:(id<InputView>*)view;
@end