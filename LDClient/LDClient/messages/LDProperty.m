//
//  Property.m
//  LaMo
//
//  Created by Ved Surtani on 13/09/11.
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
//

#import "LDProperty.h"
#import "PropertyMap.h"
#import "LDMessageParam.h"



@interface LDProperty (Private)
-(NSInvocation*)invocationForObject:(id)object selector:(SEL)selector;
-(NSInvocation*)getterInvocationForObject:(id)object;
-(NSInvocation*)setterInvocationForObject:(id)object;
@end

@implementation LDProperty
@synthesize name,getter,setter,param;



+(LDProperty*)propertyWithName:(NSString*)pName param:(LDMessageParam*)param_;
{
    NSAssert(pName!= nil && pName.length >0, @"Property Name should have one or more characters");
    LDProperty *aProperty = [[LDProperty alloc] init];
    aProperty.name = pName;
    aProperty.getter = pName;
    NSString *firstCharacterInUppercase = [[NSString stringWithFormat:@"%c",[pName characterAtIndex:0]] uppercaseString];
    NSRange range = {0,1};
    aProperty.setter = [NSString stringWithFormat:@"set%@:",[pName stringByReplacingCharactersInRange:range withString:firstCharacterInUppercase]];
    
    aProperty.param = param_;
    return aProperty;
}


+(LDProperty*)propertyWithName:(NSString*)pName type:(Class)type
{
    id<TypeAdapter> emptyValue = [[type alloc] init];
    LDMessageParam *param =  [[LDMessageParam alloc] init];
    param.value = emptyValue;
    param.displayName = pName;
    LDProperty *aProperty = [LDProperty propertyWithName:pName param:param];
    return aProperty;
}



- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.getter = [aDecoder decodeObjectForKey:@"getter"];
    self.setter = [aDecoder decodeObjectForKey:@"setter"];
    self.param = [aDecoder decodeObjectForKey:@"param"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:getter forKey:@"getter"];
    [aCoder encodeObject:setter forKey:@"setter"];
    [aCoder encodeObject:param forKey:@"param"];
}


-(void)setOnObject:(id)object
{
    NSInvocation *invocation = [self setterInvocationForObject:object];
    [invocation invoke];
}


//TODO: externalize this logic for extension
-(void)readExistingValueFromObject:(id)object
{
    NSInvocation *invocation = [self getterInvocationForObject:object];
    [invocation invoke];
    if([param.value isKindOfClass:[UIColorAdapter class]])
    {
        UIColor *color;
        [invocation getReturnValue:&color];
        if(color != nil)
        {
            CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
            if ([color respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
                [color getRed:&red green:&green blue:&blue alpha:&alpha];
            } else {
//                const CGFloat *components = CGColorGetComponents(color.CGColor);
//                red = components[0];
//                green = components[1];
//                blue = components[2];
//                alpha = components[3];
            }
            [(UIColorAdapter*)param.value setRed:red];
            [(UIColorAdapter*)param.value setGreen:green];
            [(UIColorAdapter*)param.value setBlue:blue];
            [(UIColorAdapter*)param.value setAlpha:alpha];
        }
    }
    else if([param.value isKindOfClass:[UIImageAdapter class]])
    {
         UIImage *image;
        [invocation getReturnValue:&image];
        if (image != nil) {
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            [(UIImageAdapter*)param.value setImageData:imageData];
        }
    }
    else
    {
        [invocation getReturnValue:[param.value value]];
    }
    
}

-(NSInvocation*)getterInvocationForObject:(id)object
{
    SEL selector = NSSelectorFromString(getter);
    return [self invocationForObject:object selector:selector];
}

-(NSInvocation*)setterInvocationForObject:(id)object
{
    SEL selector = NSSelectorFromString(setter);
    NSInvocation *anInvocation = [self invocationForObject:object selector:selector];
    if (param != nil) {
        void *val = [param.value value];//[param getValue];
        [anInvocation setArgument:val atIndex:2];
    }
    return anInvocation;

}
-(NSInvocation*)invocationForObject:(id)object selector:(SEL)selector
{
    NSMethodSignature *methodSignature = [[object class] instanceMethodSignatureForSelector:selector];
    NSInvocation *anInvocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [anInvocation setSelector:selector];
    [anInvocation setTarget:object];
    return anInvocation;
    
}

-(id)copy
{
    LDProperty *copy = [[LDProperty alloc] init];
    copy.getter = getter;
    copy.setter = setter;
    copy.name = name;
    copy.param = [param copyWithZone:nil];
    return  copy;
}

@end
