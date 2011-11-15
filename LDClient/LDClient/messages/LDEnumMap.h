//
//  LDEnumMap.h
//  LDClient
//
//  Created by Ved Surtani on 03/11/11.
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
#import "EnumAdapter.h"

/*!
 @class     LDEnumMap
 @brief     Map of Supported Enums as properties or message parameters.
 @details   Enums as parameters or properties are represented in @ref EnumAdapter. This is different from other adapters because it had display names and 
 corresponding values. It's actual type is integer but only the enum constants can be valid values. EnumMap provides a map of all supported enums in 
 LDClient. At the time of initialization (or even later), @ref EnumAdapters can be created for each enum that we like to be editable in LDServer and add 
 it in this map. 
 */
@interface LDEnumMap : NSObject
+(EnumAdapter*)enumForTextAlignment;
/*!
 @brief     adds the enum for the specified key in the map.
 @param     anEnum @ref EnumAdapter instance that is to be stored for the specified key.
 @details   use this method to create and add an enum adapter. This will enable the enum that EnumAdapter wraps to be passed as MessageParam across LDServer 
 and LDClient.
 */
+(void)addEnum:(EnumAdapter*)anEnum forKey:(NSString*)key;

/*!
 @brief     returns the enum stored for the specified key or nil if the key is not foud
 */
+(EnumAdapter*)enumForKey:(NSString*)key;
@end
