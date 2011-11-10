//
//  LMMessageParamInt.h
//  LaMo
//
//  Created by Ved Surtani on 07/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TypeAdapter.h"
@interface IntegerAdapter : NSObject<TypeAdapter>
{
    NSInteger integer;
}

@property(nonatomic)NSInteger integer;
@end
