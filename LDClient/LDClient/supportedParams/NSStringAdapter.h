//
//  LMMessageParamString.h
//  LaMo
//
//  Created by Ved Surtani on 07/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LDMessageParam.h"

@interface LDMessageParamString : LDMessageParam
{
    NSString *text;
}
@property(nonatomic,strong)NSString *text;
@end
