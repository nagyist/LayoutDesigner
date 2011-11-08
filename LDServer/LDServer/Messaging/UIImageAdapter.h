//
//  LMMessageParamImage.h
//  LaMo
//
//  Created by Ved Surtani on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "TypeAdapter.h"

#import "CodeGenerating.h"
@interface UIImageAdapter : NSObject<TypeAdapter,CodeGenerating>
{
    NSData *imageData;
    
    @private
    NSImage *image;
}
@property(nonatomic,strong)NSData *imageData;
@end
