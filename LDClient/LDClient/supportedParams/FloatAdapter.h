//
//  LMMessageParamFloat.h
//  LaMo
//
//  Created by Ved Surtani on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "TypeAdapter.h"
@interface FloatAdapter : NSObject<TypeAdapter>
{
    float aFloat;
}
@property(nonatomic)float aFloat;
@end
