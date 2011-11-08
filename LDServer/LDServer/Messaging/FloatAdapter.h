//
//  LMMessageParamFloat.h
//  LaMo
//
//  Created by Ved Surtani on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "TypeAdapter.h"
#import "InputRendering.h"
#import "CodeGenerating.h"
@interface FloatAdapter : NSObject<TypeAdapter,InputRendering,CodeGenerating>
{
    float aFloat;
}
@property(nonatomic)float aFloat;
@end
