//
//  LMMessageParamString.h
//  LaMo
//
//  Created by Ved Surtani on 07/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TypeAdapter.h"
#import "InputRendering.h"
#import "CodeGenerating.h"
@interface NSStringAdapter : NSObject<TypeAdapter,InputRendering,CodeGenerating>
{
    NSString *text;
}
@property(nonatomic,strong)NSString *text;
@end