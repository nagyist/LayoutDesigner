//
//  LMMessageParamEnum.h
//  LaMo
//
//  Created by Ved Surtani on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "TypeAdapter.h"
#import "CodeGenerating.h"
@interface EnumAdapter : NSObject<TypeAdapter,CodeGenerating>
{
    NSArray *displayNames;
    NSArray *integerValuesAsString;
    
    int selectedValue;
}
@property(nonatomic,strong)NSArray *displayNames;
@property(nonatomic,strong)NSArray *integerValuesAsString;
@property(nonatomic) int selectedValue;
@end
