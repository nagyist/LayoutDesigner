//
//  LMMessageParamString.h
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
//

#import "TypeAdapter.h"


/*!
 @class     NSStringAdapter
 @brief     wrapper for NSString values.
 @details   Create instance of this adapter for passing/receiving string objects to/from remote process.
 */
@interface NSStringAdapter : NSObject<TypeAdapter>
{
    NSString *text;
}

/*!
 @property      text
 @brief         the string value.
 */
@property(nonatomic,strong)NSString *text;
@end
