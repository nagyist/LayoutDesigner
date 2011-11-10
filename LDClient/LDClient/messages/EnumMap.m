//
//  EnumHelper.m
//  LDClient
//
//  Created by Ved Surtani on 03/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EnumMap.h"
#import "EnumAdapter.h"

static inline NSString* stringValue(int val){
    return [NSString stringWithFormat:@"%d",val];
};

static EnumAdapter *textAlignment;

static NSMutableDictionary *enums;
@implementation EnumMap
+(void)initialize
{
    enums = [[NSMutableDictionary alloc] init];
    
    //create enums
    
    textAlignment = [[EnumAdapter alloc] init];
    textAlignment.displayNames = [NSArray arrayWithObjects:@"Left",@"Right",@"Center", nil];
    textAlignment.integerValuesAsString = [NSArray arrayWithObjects:stringValue(UITextAlignmentLeft),
                                           stringValue(UITextAlignmentRight),
                                           stringValue(UITextAlignmentCenter), nil];
    [enums setObject:textAlignment forKey:@"UITextAlignment"];
    
}

+(EnumAdapter*)enumForTextAlignment
{
    return [textAlignment copy];
}

+(void)addEnum:(EnumAdapter*)anEnum forKey:(NSString*)key
{
    [enums setObject:[anEnum copy] forKey:key];
}
+(EnumAdapter*)enumForKey:(NSString*)key
{
    return [[enums objectForKey:key] copy];
}
@end
