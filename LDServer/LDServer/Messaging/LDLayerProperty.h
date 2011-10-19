//
//  LayerProperty.h
//  LaMo
//
//  Created by Ved Surtani on 04/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LDProperty.h"
@interface LDLayerProperty : LDProperty

/*!
 @brief     returns the code that applies the change to layer.
 @details   ovverriden to generate the code on the layer of selected view. Example: LDProperty returns code like mView.property = smething. This returns
 mView.layer.property = something.
 */
-(NSString*)getCode;
@end
