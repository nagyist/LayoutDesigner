//
//  LMMessageParamColor.h
//  LaMo
//
//  Created by Ved Surtani on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "TypeAdapter.h"

#import "CodeGenerating.h"
@interface UIColorAdapter : NSObject<TypeAdapter,CodeGenerating>
{
    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;
    
    @private
    NSColor *color;
}
@property(nonatomic)CGFloat red;
@property(nonatomic)CGFloat blue;
@property(nonatomic)CGFloat green;
@property(nonatomic)CGFloat alpha;
@end
