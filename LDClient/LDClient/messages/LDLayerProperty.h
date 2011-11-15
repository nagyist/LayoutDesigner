//
//  LayerProperty.h
//  LaMo
//
//  Created by Ved Surtani on 04/10/11.
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

#import "LDProperty.h"
#import <QuartzCore/QuartzCore.h>


/*!
 @class     LDLayerProperty
 @extends   LDProperty
 @brief     Subclass of @ref LDProperty which is essentially the property of the object's CALayer.
 @details   If an object is instance of UIView or it's subclass, then the object will have a layer. All properties of this layer are represented by this
 class. Use the instances of this class to read and set the layer properties of UIView instances.
 */
@interface LDLayerProperty : LDProperty

/*!
 @brief     returns the instance of this class with specified property name and param. 
 @details   read more on how this works in @ref LDProperty.
 */
+(LDLayerProperty*)propertyWithName:(NSString*)pName param:(LDMessageParam*)param_;

/*!
 @brief     returns property instance with specified name and type. Read more in @ref LDProeprty.
 @param     pName name of property. Example cornerRadius.
 @param     type Class implementing @ref TypeAdapter protocol that represents the type of the property. Example float, integer or a complex type.
 @ref       LDProperty
 */
+(LDLayerProperty*)propertyWithName:(NSString*)pName type:(Class)type;
@end
