//
//  LMMessageParam.h
//  LaMo
//
//  Created by Ved Surtani on 07/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeAdapter.h"
@interface LDMessageParam : NSObject<NSCoding,NSCopying>
{
    NSString *displayName;

}

@property(nonatomic,strong)NSString *displayName;
@property(strong)id<TypeAdapter> value;

-(void*)getValue;
+(LDMessageParam*)paramWithValue:(id<TypeAdapter>)typeAdapter;
@end
