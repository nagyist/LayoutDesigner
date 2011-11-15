//
//  LayerProperty.m
//  LaMo
//
//  Created by Ved Surtani on 04/10/11.
//  Copyright 2011 Imaginea 
//  Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at

//  http://www.apache.org/licenses/LICENSE-2.0

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

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

+(LDLayerProperty*)propertyWithName:(NSString*)pName type:(Class)type
{
    id<TypeAdapter> emptyValue = [[type alloc] init];
    LDMessageParam *param = [LDMessageParam paramWithValue:emptyValue];
    return [LDLayerProperty propertyWithName:pName param:param];
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


-(id)copy
{
    LDLayerProperty *copy = [[LDLayerProperty alloc] init];
    copy.name = name;
    copy.getter = getter;
    copy.setter = setter;
    copy.param = [param copyWithZone:nil];
    return copy;
}
@end
