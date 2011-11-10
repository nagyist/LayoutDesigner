//
//  LMMessageParamColor.h
//  LaMo
//
//  Created by Ved Surtani on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "TypeAdapter.h"
@interface UIColorAdapter : NSObject<TypeAdapter>
{
    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;
    
    @private
    UIColor *color;
}
@property(nonatomic)CGFloat red;
@property(nonatomic)CGFloat blue;
@property(nonatomic)CGFloat green;
@property(nonatomic)CGFloat alpha;
@end
