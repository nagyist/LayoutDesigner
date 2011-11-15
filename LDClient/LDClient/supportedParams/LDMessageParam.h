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
//

#import <Foundation/Foundation.h>
#import "TypeAdapter.h"

/*!
 @class     LDMessageParam
 @brief     LDMessageParam is used for providing parameters for messages and properties. 
 @details   When a message is to be sent to a remote object this class is used to wrap a single parameter. This is also used as a wrapper around 
 property @ref LDProperty. To create a LDProperty/LDMessage for applying/executing on an object, 
 create an instance of this class and provide the type (primitive or complex) as a value. 
 @ref       LDProperty
 @ref       LDMessage
 @ref       TypeAdapter
 */
@interface LDMessageParam : NSObject<NSCoding,NSCopying>
{
    NSString *displayName;

}

/*!
 @property      displayName
 @brief         displayName if any helps in displaying a text describing the parameter.
 @details       One use of displayName is when LDServer ui displays the text next to the property input view. Also this is used when messages have multiple 
 parameters and this text is used to describe the parameter being edited in LDServer.
 */
@property(nonatomic,strong)NSString *displayName;

/*!
 @property      value
 @brief         the value of this parameter
 @details       value serves two purposes. It wraps the type of parameter (int,NSString or any complex or primitive type) and also it provides a way to 
 read and write the value into it. Example, LDClient sends this with a populated with initial value of a property and LDServer sets it to new value when 
 user changes it there. Then the property object is sent back for applying with the new value.
 */
@property(strong)id<TypeAdapter> value;

///*!
// @brief     returns the address of the buffer where value is stored
// @details   to get the value of
// */
//-(void*)getValue;

/*!
 @brief     creates a LDMessageParam instance with provided value
 @details   @ref TypeAdapter instance wraps a single value along with it's type. The wrapper/adapter is mainly used for adapting a type from iOS to 
 OSX platform and vice versa.
 */
+(LDMessageParam*)paramWithValue:(id<TypeAdapter>)typeAdapter;
@end
