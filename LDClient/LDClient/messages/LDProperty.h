//
//  Property.h
//  LaMo
//
//  Created by Ved Surtani on 13/09/11.
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
#import <QuartzCore/QuartzCore.h>


/*!
 @class     LDProperty
 @brief     This class represents an objC property. This can be used to read and set properties on a given object.
 @details   If we have a UILabel instance and we want to set it's text then we take the corresponding LDProperty object, change it's value
 and apply on the label instance. This can also be used for reading a property of provided object. See @ref readExistingValueFromObject: .
 */
@interface LDProperty : NSObject
{
    NSString *name;
    NSString *getter;
    NSString *setter;
    
    LDMessageParam  *param;
}

/*!
 @property      name
 @brief         name of the property
 */
@property(nonatomic,strong)NSString *name;

/*!
 @property      getter
 @brief         the getter selector as string.
 @details       This by default is derived from the name. It can be overriden if the getter is not same as @ref name
 */
@property(nonatomic,strong)NSString *getter;

/*!
 @property      setter
 @brief         the setter selector as string
 @details       This by default is derived from the name aka setName:. It can be overriden if the setter is custom.
 */
@property(nonatomic,strong)NSString *setter;

/*!
 @property      param
 @brief         The @ref LDMessageParam which holds the type and value of property
 @details       param always holds the type and a value. Type is always there where as value can be empty in the beginning. Setting this is mendatory 
 for LDProperty to make any sense. Value in the param can be empty in the beginning and can be populated later when it's assosciate with an actual instance.
 */
@property(nonatomic,strong)LDMessageParam *param;

/*!
 @brief     creates and returns instance of LDProperty with given name and type.
 @param     pName the name of property.
 @param     type class implementing @ref TypeAdapter. This represents the class/type(primitive or complex) of property.
 @details   This method is used for creating an instance of property with name and type. The returned instance is initialized with getter, setter and 
 @ref param with type and empty value. 
 */
+(LDProperty*)propertyWithName:(NSString*)pName type:(Class)type;

/*!
 @brief     creates and returns instance of this class with given property name and type,value in param
 @param     pName name of the property.
 @param     param_ @ref LDMessageParam instance that holds type and/or value of the property.
 @details   This method is useful when you need to initialize the @ref LDMessageParam instance before creating LDProperty. Example of this would be a 
 property that represents an Enum. An enum might require extra initialization of setting the display names for options and their integer values, etc 
 instead of simply specifying the type.
 */
+(LDProperty*)propertyWithName:(NSString*)pName param:(LDMessageParam*)param_;

/*!
 @brief     reads the value of property from the given object and puts it in the @ref LDMessageParam.
 @param     object the object whose property value is to be read
 @details   This method is called for reading property value from the object. A property is initialized with name and type. After calling this method, the 
 value is stored in @ref LDMessageParam.
 */
-(void)readExistingValueFromObject:(id)object;

/*!
 @brief     sets the property in the target object.
 @param     object the target object whose property is to be set.
 @details   This method is used for applying the @ref LDProperty on a target object. The value that is stored in @ref LDMessageParam is the new value 
 of target object's property. Example, if the property represents "text" and it's value is a string then on applying this LDProperty instance 
 on a UILabel instance will change the text of the label.
 */
-(void)setOnObject:(id)object;


@end

