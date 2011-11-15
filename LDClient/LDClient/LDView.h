//
//  SubviewTree.h
//  LayoutModifier
//
//  Created by Ved Surtani on 17/08/11.
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

#import "TreeNode.h"

/*!
 @class     LDView
 @brief     This class has multiple purposes. It wraps an instance of UIView or it's subclasses. It also represents a view tree. With subviews as children 
 all the descendent subviews can be reached with normal tree operations. It is also used as Adapter for UIView which is then transferred to LDServer for 
 manipulation. When instance of LDView is selected on LDServer it becomes active and any changes made on LDServer are reflected on iOS application 
 instantly.
 */
@interface LDView : NSObject<NSCoding,TreeNode>
{

    UIView *__weak view;
    NSString *name;
    NSInteger identifier;
    CGRect frame;
    NSMutableArray *children;
    NSArray *messages;
    NSArray *properties;
    
}


/*!
 @property      name
 @brief         a displayable name for the user to identify the view.
 @details       LDServer uses this to display a tree of views with name as text for each view. LDServer also uses it for code generation. It used the name 
 as variable name. Set this property properly for better readablility and code generation. By default if accessibilty hint is set for a view, it is used 
 as name else it uses the class name of the view instance.
 */
@property(nonatomic,strong)NSString *name;

/*!
 @property  identifier
 @brief     an auto generated identifier
 @details   This identifier is used by LDClient and LDServer to communicate which view they are talking about with each other. Do not set this property 
 directly. The identifier is generated whenever @ref LDView is given a new UIView (or subclasses) instance to create a tree. See property @ref view.
 */
@property(nonatomic)NSInteger identifier;

/*!
 @property      view
 @brief         the underlying UIView this LDView instance is wrapping/adapting to.
 @details       setting this property creates a whole tree of views. When you set a view, all it;s subviews are iterated and new LDView instances are 
 created recursively and added into the children array.
 */
@property(nonatomic,weak)UIView *view;

/*!
 @property      children
 @brief         the array of LDView instances which represent the subviews of the view current instance represents.
 @details       This array gives all the subviews.
 */
@property(nonatomic,strong)NSMutableArray *children;

/*!
 @property      messages
 @brief         array of @ref LDMessage instances. It gives all the supported messages that can be sent to the UIView this instance wraps.
 @details       Example this array can have a @ref LDMessage representing setBackgroundColor: or even a custom message that is supported for a custom 
 UIView subclass.
 */
@property(nonatomic,strong)NSArray *messages;

/*!
 @property      properties
 @brief         array of @ref LDProperty instances. It gives all the supported properties that can be read/set on the UIView this instance wraps.
 @details       Example: text can be one property in this array if the LDView instance is wrapping a UILabel and provided text is supported property 
 for UILabel. See @ref LDPropertyMap for more infor on supported properties.
 */
@property(nonatomic,strong)NSArray *properties;
@end
