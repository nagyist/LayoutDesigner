//
//  MessageHelper.m
//  LaMo
//
//  Created by Ved Surtani on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PropertyMap.h"
#import "LDProperty.h"
#import "LDLayerProperty.h"
#import "EnumMap.h"
@implementation NSArray (deepCopy)
-(NSArray*)deepCopy
{
    NSMutableArray *copy = [[NSMutableArray alloc] init];
    for(id object in self)
    {
        [copy addObject:[object copy]];
    }
    return copy;
}
@end

@interface PropertyMap (Private)
+(void)addDefaultClassesAndProperties;
@end

static NSMutableSet *supportedClasses;
static PropertyMap *defaultPropertyMap;
@implementation PropertyMap
@synthesize targetObject;



+(PropertyMap*)defaultPropertyMap
{
    if (defaultPropertyMap == nil) {
        defaultPropertyMap = [[PropertyMap alloc] init];
        [PropertyMap addDefaultClassesAndProperties];
    }
    return defaultPropertyMap;
}

+(void)setDefaultMap:(PropertyMap*)map
{
    defaultPropertyMap = map;
}

+(void)addDefaultClassesAndProperties
{
    
    //add default supported classes
    [defaultPropertyMap  addSupportedClass:[UIView class]];
    [defaultPropertyMap addSupportedClass:[UILabel class]];
    [defaultPropertyMap addSupportedClass:[UIImageView class]];
    
    
    //for each default added class add a method for creating default properties
    //here we iterate over each supported class (default) for getting their default properties
    for(Class type in [defaultPropertyMap supportedClasses])
    {
        
            NSString *selectorString = [NSString stringWithFormat:@"propertiesFor%@",type];
            SEL selector = NSSelectorFromString(selectorString);
            if ([defaultPropertyMap respondsToSelector:selector]) {
                NSArray *propertiesForType = [defaultPropertyMap performSelector:selector];
                for(LDProperty* property in propertiesForType)
                [defaultPropertyMap addProperty:property forClass:type];
            }
            else
            {
                NSLog(@"%@ method not found! Implement and return property list",selectorString);
            }
    }

}

+(void)initialize
{
    supportedClasses = [[NSMutableSet alloc] init];
    [supportedClasses addObject:[UIView class]];
    [supportedClasses addObject:[UILabel class]];
    [supportedClasses addObject:[UIImageView class]];
    
}

-(id)init
{
    self = [super init];
    propertiesForClassDictionary = [[NSMutableDictionary alloc] init];
    return self;
}
+(NSArray*)propertiesForObject:(id)object
{
    NSMutableArray *properties = [[NSMutableArray alloc] init];
    PropertyMap *helper = [[PropertyMap alloc] init];
    helper.targetObject = object;
    for(Class type in supportedClasses)
    {
        if ([object isKindOfClass:type]) {
            NSString *selectorString = [NSString stringWithFormat:@"propertiesFor%@",type];
            SEL selector = NSSelectorFromString(selectorString);
            if ([helper respondsToSelector:selector]) {
                NSArray *propertiesForType = [helper performSelector:selector];
                [properties addObjectsFromArray:propertiesForType];
            }
            else
            {
                NSLog(@"%@ method not found! Implement and return property list",selectorString);
            }
        }
    }
    DLog(@"Property Count = %d", [properties count]);
    [properties makeObjectsPerformSelector:@selector(readExistingValueFromObject:) withObject:object];
    return properties;
}


-(void)addSupportedClass:(Class)aClass
{
    if ([propertiesForClassDictionary objectForKey:aClass] == nil) {
        NSMutableArray *arrayOfProperties = [[NSMutableArray alloc] init];
        [propertiesForClassDictionary setObject:arrayOfProperties forKey:aClass];
    }
}

-(void)removeSupportedClass:(Class)aClass
{
    [propertiesForClassDictionary removeObjectForKey:aClass];
}

-(NSArray*)propertiesForObject:(id)object
{
    NSMutableArray *arrayOfProperties = [[NSMutableArray alloc] init];
    for(Class aClass in [propertiesForClassDictionary allKeys])
    {
        if([object isKindOfClass:aClass])
        {
            [arrayOfProperties addObjectsFromArray:[[propertiesForClassDictionary objectForKey:aClass] deepCopy]];   
        }
    }
    [arrayOfProperties makeObjectsPerformSelector:@selector(readExistingValueFromObject:) withObject:object];
    return arrayOfProperties;
}

-(void)addProperty:(LDProperty*)aProperty forClass:(Class)aClass
{
    if([propertiesForClassDictionary objectForKey:aClass] == nil)
    {
        [self addSupportedClass:aClass];
    }
    NSMutableArray *arrayOfProperties = [propertiesForClassDictionary objectForKey:aClass];
    [arrayOfProperties addObject:[aProperty copy]];
}


-(void)removePropertyWithName:(NSString*)propertyName forClass:(Class)aClass
{
    NSMutableArray *arrayOfProperties = [propertiesForClassDictionary objectForKey:aClass];
    if(arrayOfProperties == nil){
        return;
    }
   for(LDProperty *property in [arrayOfProperties copy])
   {
       if ([property.name isEqualToString:propertyName]) {
           [arrayOfProperties removeObject:property];
       }
   }

}

-(NSArray*)supportedClasses
{
    return [propertiesForClassDictionary allKeys];
}


#pragma 
#pragma create properties for each class
-(NSArray*)propertiesForUIView
{
    NSMutableArray *arrayOfProperties = [[NSMutableArray alloc] init];
    
    [arrayOfProperties addObject:[LDProperty propertyWithName:@"frame" type:[CGRectAdapter class]]];
    [arrayOfProperties addObject:[LDProperty propertyWithName:@"backgroundColor" type:[UIColorAdapter class]]];
    [arrayOfProperties addObject:[LDProperty propertyWithName:@"alpha" type:[FloatAdapter class]]];
    [arrayOfProperties addObject:[LDLayerProperty propertyWithName:@"cornerRadius" type:[FloatAdapter class]]];
    //TODO: test with testCase
    // [arrayOfProperties addObject:[LDLayerProperty propertyWithName:@"cornerRadiues" type:[LDMessageParamFloat class]]];
    return arrayOfProperties;
}

-(NSArray*)propertiesForUILabel
{
    NSMutableArray *arrayOfProperties = [[NSMutableArray alloc] init];
    
    [arrayOfProperties addObject:[LDProperty propertyWithName:@"text" type:[NSStringAdapter class]]];
    [arrayOfProperties addObject:[LDProperty propertyWithName:@"textColor" type:[UIColorAdapter class]]];
    
    [arrayOfProperties addObject:[LDProperty propertyWithName:@"textAlignment" param:
                                  [LDMessageParam paramWithValue:[EnumMap enumForTextAlignment]]]];
    return arrayOfProperties;
}

-(NSArray*)propertiesForUIImageView
{
    NSMutableArray *arrayOfProperties = [[NSMutableArray alloc] init];
    
    [arrayOfProperties addObject:[LDProperty propertyWithName:@"image" type:[UIImageAdapter class]]];
    return arrayOfProperties;
}



@end
