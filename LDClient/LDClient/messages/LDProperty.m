//
//  Property.m
//  LaMo
//
//  Created by Ved Surtani on 13/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LDProperty.h"
#import "MessageHelper.h"


@implementation LDProperty
@synthesize name,getter,setter,param;



+(LDProperty*)propertyWithName:(NSString*)pName param:(LDMessageParam*)param_
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

-(void)readExistingValueFromObject:(id)object
{
    NSInvocation *invocation = [self getterInvocationForObject:object];
    [invocation invoke];
    
    if ([param isKindOfClass:[LDMessageParamCGRect class]]) {
        CGRect returnValue;
        [invocation getReturnValue:&returnValue];
        [(LDMessageParamCGRect*)param setRect:returnValue];
    }
    else if ([param isKindOfClass:[LDMessageParamColor class]]) {
        ;      //do nothing for now
    }
    
    else if ([param isKindOfClass:[LDMessageParamEnum class]]) {
        int returnValue;
        [invocation getReturnValue:&returnValue];
        [(LDMessageParamEnum*)param setSelectedValue:returnValue];
    }
    
    else if ([param isKindOfClass:[LDMessageParamFloat class]]) {
        float returnValue;
        [invocation getReturnValue:&returnValue];
        [(LDMessageParamFloat*)param setAFloat:returnValue];
    }
    
    else if ([param isKindOfClass:[LDMessageParamImage class]]) {
        UIImage  __unsafe_unretained *returnValue;
        
        [invocation getReturnValue:&returnValue];
        if (returnValue) {
          NSData *imageData =   UIImagePNGRepresentation(returnValue);
            [(LDMessageParamImage*)param setImageData:imageData];
        }
    }
    
    else if ([param isKindOfClass:[LDMessageParamInt class]]) {
        int returnValue;
        
        [invocation getReturnValue:&returnValue];
        [(LDMessageParamInt*)param setInteger:returnValue];
    }

    else if ([param isKindOfClass:[LDMessageParamString class]]) {
        NSString __unsafe_unretained *returnValue;
        
        [invocation getReturnValue:&returnValue];
        [(LDMessageParamString*)param setText:returnValue];
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
        void *val = [param value];
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



@end
