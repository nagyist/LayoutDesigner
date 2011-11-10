//
//  EnumHelper.h
//  LDClient
//
//  Created by Ved Surtani on 03/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnumAdapter.h"

@interface EnumMap : NSObject
+(EnumAdapter*)enumForTextAlignment;
+(void)addEnum:(EnumAdapter*)anEnum forKey:(NSString*)key;
+(EnumAdapter*)enumForKey:(NSString*)key;
@end
