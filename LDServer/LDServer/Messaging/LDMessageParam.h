//
//  LMMessageParam.h
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

#import <Foundation/Foundation.h>
#import "ControlView.h"
#import "TypeAdapter.h"
@protocol LMMessageParamDelegate;
@interface LDMessageParam : NSObject<NSCoding,ControlViewDelegate,NSCopying>
{
    NSString *displayName;
    
    id<LMMessageParamDelegate> delegate;

}
@property(nonatomic,assign)id<LMMessageParamDelegate>delegate;
@property(nonatomic,retain)NSString *displayName;
@property(strong)id<TypeAdapter> value;
-(void*)getValue;
-(ControlView*)viewForCollectingData;
-(void)sendUpdate;

/*!
 @brief     generate the rhs of the code
 @details   All subclasses should implement this method and return the code for right hand side of the expression.
 Example: for LDMessageParamCGRect the code will be "CGRectMake(x,y,w,h)" 
 */
-(NSString*)getCode;
@end



@protocol LMMessageParamDelegate <NSObject>
-(void)valueChanged:(LDMessageParam*)param;
@end