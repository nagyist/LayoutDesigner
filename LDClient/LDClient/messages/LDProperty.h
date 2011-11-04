//
//  Property.h
//  LaMo
//
//  Created by Ved Surtani on 13/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDMessageParam.h"
@interface LDProperty : NSObject
{
    NSString *name;
    NSString *getter;
    NSString *setter;
    
    LDMessageParam  *param;
}

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *getter;
@property(nonatomic,strong)NSString *setter;
@property(nonatomic,strong)LDMessageParam *param;


+(LDProperty*)propertyWithName:(NSString*)pName param:(LDMessageParam*)param_;
+(LDProperty*)propertyWithName:(NSString*)pName type:(Class)type;
+(LDProperty*)propertyWithName:(NSString*)pName type:(Class)type target:(id)target;
-(NSInvocation*)invocationForObject:(id)object selector:(SEL)selector;
-(NSInvocation*)getterInvocationForObject:(id)object;
-(NSInvocation*)setterInvocationForObject:(id)object;
-(void)setOnObject:(id)object;
-(void)readExistingValueFromObject:(id)object;


@end

