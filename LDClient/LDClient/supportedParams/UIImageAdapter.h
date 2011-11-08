//
//  LMMessageParamImage.h
//  LaMo
//
//  Created by Ved Surtani on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LDMessageParam.h"

@interface LDMessageParamImage : LDMessageParam
{
    NSData *imageData;
    
    @private
    UIImage *image;
}
@property(nonatomic,strong)NSData *imageData;
@end
