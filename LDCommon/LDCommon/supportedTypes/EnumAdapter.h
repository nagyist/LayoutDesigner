//
//  LMMessageParamEnum.h
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
//


//TODO: create integerValues array which stores NSValue instead of NSStrings.

#import "TypeAdapter.h"


/*!
 @class     EnumAdapter
 @brief     The adapter for enum type struct. This class provides the displayNames which are the options in the enum and integerValues for each 
 option in a separate array. 
 @details   The adapter for enum has options in readable texts and their integer values in another array. This is used to wrap an enum type with it;s 
 current value.
 */
@interface EnumAdapter : NSObject<TypeAdapter>
{
    NSArray *displayNames;
    NSArray *integerValuesAsString;
    
    int selectedValue;
}


/*!
 @property      displayNames
 @brief         array of readable texts which represent each enum option.
 @details       Example: a UITextAlignment enum can have display names as left,right and center.
 */
@property(nonatomic,strong)NSArray *displayNames;

/*!
 @property      integerValuesAsString
 @brief         array of integers as string which are values corresponding the to each text in @ref displayNames
 */
@property(nonatomic,strong)NSArray *integerValuesAsString;

/*!
 @property      selectedValue
 @brief         the value of this enum as integer.
 */
@property(nonatomic) int selectedValue;
@end
