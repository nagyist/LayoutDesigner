//
//  MessageHelper.h
//  LaMo
//
//  Created by Ved Surtani on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDMessageParam.h"
#import "CGRectAdapter.h"
#import "UIColorAdapter.h"
#import "EnumAdapter.h"
#import "FloatAdapter.h"
#import "FloatAdapter.h"
#import "IntegerAdapter.h"
#import "NSStringAdapter.h"
#import "UIImageAdapter.h"
#import "LDMessage.h"
#import "LDProperty.h"
#import <QuartzCore/QuartzCore.h>
@interface PropertyMap : NSObject
{
   @private 
    NSMutableDictionary *propertiesForClassDictionary;
    
}
@property(weak)id targetObject;

+(PropertyMap*)defaultPropertyMap;
+(void)setDefaultMap:(PropertyMap*)map;
-(void)addSupportedClass:(Class)aClass;
-(NSArray*)supportedClasses;
-(void)removeSupportedClass:(Class)aClass;
-(NSArray*)propertiesForObject:(id)object;
-(void)addProperty:(LDProperty*)aProperty forClass:(Class)aClass;
-(void)removePropertyWithName:(NSString*)propertyName forClass:(Class)aClass;

@end
