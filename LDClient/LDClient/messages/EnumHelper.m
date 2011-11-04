//
//  EnumHelper.m
//  LDClient
//
//  Created by Ved Surtani on 03/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EnumHelper.h"
#import "LDMessageParamEnum.h"

static inline NSString* stringValue(int val){
    return [NSString stringWithFormat:@"%d",val];
};

static LDMessageParamEnum *textAlignment;

static NSMutableDictionary *enums;
@implementation EnumHelper
+(void)initialize
{
    enums = [[NSMutableDictionary alloc] init];
    
    //create enums
    
    textAlignment = [[LDMessageParamEnum alloc] init];
    textAlignment.displayNames = [NSArray arrayWithObjects:@"Left",@"Right",@"Center", nil];
    textAlignment.integerValuesAsString = [NSArray arrayWithObjects:stringValue(UITextAlignmentLeft),
                                           stringValue(UITextAlignmentRight),
                                           stringValue(UITextAlignmentCenter), nil];
}

+(LDMessageParamEnum*)enumForTextAlignment
{
    return [textAlignment copy];
}
@end
