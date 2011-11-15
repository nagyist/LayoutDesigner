//
//  LDPropertyMap.h
//  LDClient
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
//

#import <Foundation/Foundation.h>
#import "LDMessageParam.h"
#import "CGRectAdapter.h"
#import "UIColorAdapter.h"
#import "EnumAdapter.h"
#import "FloatAdapter.h"
#import "FloatAdapter.h"
#import "IntegerAdapter.h"
#import "NSStringAdapter.h"
#import "UIImageAdapter.h"
#import "LDMessage.h"
#import "LDProperty.h"

/*!
 @class     LDPropertyMap
 @brief     Editable Dictionary of supported properties. This class serves as a map of supported classes, instances of which can be modified from LDServer.
 @details   Supported classes are the ones whose instances can be modified by LDServer by applying properties and sending messages to them. Only those 
 properties can be modified which are present in this map. The map stores an array of @ref LDProperty instances for each supported class.
 @ref LDProperty. The list of properties is not only for the class of object, but it includes properties of all it's super classes that are in the map.
 */
@interface LDPropertyMap : NSObject
{
   @private 
    NSMutableDictionary *propertiesForClassDictionary;
    
}

/*!
 @brief     returns the default LDPropertyMap instance.
 @details   the default instance has the default supported properties and their classes already initialized. If you want a fresh map create using alloc init 
 and add the supported properties.
 */
+(LDPropertyMap*)defaultPropertyMap;

/*!
 @brief     sets the defaultPropertyMap for entire application.
 @details   setting this to a different map will make the entire application use this map and all the properties and classes in this map are then available 
 for modification/editing.
 */
+(void)setDefaultMap:(LDPropertyMap*)map;

/*!
 @brief     adds a supported class in the map.
 @param     aClass Class which to be added in the list of supported classes.
 @details   a supported class means that instance of this class can be manipulated from the remote LDServer.
 */
-(void)addSupportedClass:(Class)aClass;

/*!
 @brief     returns the array of all supported classes.
 */
-(NSArray*)supportedClasses;

/*!
 @brief     removes the class from the map. All properties assosciated with it are also removed.
 @details   removing a class from the map will also remove all properties assosciated with it.
 */
-(void)removeSupportedClass:(Class)aClass;

/*!
 @brief     returns an array of @ref LDProperty instances for the given object.
 @details   The array contains all the properties that this object can respond to and are supported. That is all the properties registered in the map for 
 the class of this object and also all the supert classes which are in the @ref LDPropertyMap.
 */
-(NSArray*)propertiesForObject:(id)object;

/*!
 @brief     adds the property in the map for the specified class as key
 @param     aProperty @ref LDProperty instance to be stored in the map.
 @param     aClass the class of objects this property will work.
 @details   Use this method to add a property in the list of properties that can be edited from LDServer (supported properties) for a class.
 */
-(void)addProperty:(LDProperty*)aProperty forClass:(Class)aClass;

/*!
 @brief     removes the property with specified name from the list of properties of the specified class.
 @param     propertyName the name of property to be removed
 @param     aClass the class in which to search for this property.
 @details   It removes the property with specified name only from the list of properties of the specified class.
 */
-(void)removePropertyWithName:(NSString*)propertyName forClass:(Class)aClass;

@end
