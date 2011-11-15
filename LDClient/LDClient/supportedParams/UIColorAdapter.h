//
//  LMMessageParamColor.h
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


#import "TypeAdapter.h"

/*!
 @class     UIColorAdapter
 @brief     The adapter for UIColor. Adapts between UIColor in iOS and CGColor on LDServer (Mac platform).
 @details   The Adapter supports only RGBA colors. Patterns and complex color that cannot be fully created with R,G,B and A cannot be used with this.
 */
@interface UIColorAdapter : NSObject<TypeAdapter>
{
    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;
    
    @private
    UIColor *color;
}
/*!
 @property      red
 @brief         the red component of the color.
 */
@property(nonatomic)CGFloat red;

/*!
 @property      blue
 @brief         the blue component of the color.
 */
@property(nonatomic)CGFloat blue;

/*!
 @property      green
 @brief         the green component of the color.
 */
@property(nonatomic)CGFloat green;

/*!
 @property      alpha
 @brief         the alpha component of the color.
 */
@property(nonatomic)CGFloat alpha;
@end
