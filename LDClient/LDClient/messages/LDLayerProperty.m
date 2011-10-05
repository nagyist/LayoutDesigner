//
//  LayerProperty.m
//  LaMo
//
//  Created by Ved Surtani on 04/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LDLayerProperty.h"

@implementation LDLayerProperty


+(LDLayerProperty*)propertyWithName:(NSString*)pName param:(LDMessageParam*)param_
{
    NSAssert(pName!= nil && pName.length >0, @"Property Name should have one or more characters");
    LDLayerProperty *aProperty = [[LDLayerProperty alloc] init];
    aProperty.name = pName;
    aProperty.getter = pName;
    NSString *firstCharacterInUppercase = [[NSString stringWithFormat:@"%c",[pName characterAtIndex:0]] uppercaseString];
    NSRange range = {0,1};
    aProperty.setter = [NSString stringWithFormat:@"set%@:",[pName stringByReplacingCharactersInRange:range withString:firstCharacterInUppercase]];
    
    aProperty.param = param_;
    return aProperty;
}

-(void)setOnObject:(id)object
{
    UIView *view = (UIView*)object;
    [super setOnObject:[view layer]];
}

-(void)readExistingValueFromObject:(id)object
{
     UIView *view = (UIView*)object;
    [super readExistingValueFromObject:[view layer]];
}
@end
