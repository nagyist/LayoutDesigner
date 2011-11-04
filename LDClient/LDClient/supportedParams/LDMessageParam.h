//
//  LMMessageParam.h
//  LaMo
//
//  Created by Ved Surtani on 07/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDMessageParam : NSObject<NSCoding,NSCopying>
{
    NSString *displayName;

}

@property(nonatomic,strong)NSString *displayName;


-(void*)value;
@end
