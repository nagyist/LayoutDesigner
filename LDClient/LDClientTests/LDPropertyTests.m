//
//  LDPropertyTests.m
//  LDClient
//
//  Created by Ved Surtani on 15/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LDPropertyTests.h"
#import "LDPropertyMap.h"
#import "LDProperty.h"
#import "LDCommandMap.h"
#import "DefaultCommandHandler.h"
#import <UIKit/UIKit.h>
//#import "application_headers" as required

@implementation LDPropertyTests


-(void)setUp
{
    [super setUp];
    [LDClient start];
    propertyMap = [LDPropertyMap defaultPropertyMap];
    dummyProperty = [LDProperty propertyWithName:@"ved" type:NSClassFromString(@"NSStringAdapter")];
}


-(void)testPropertyMapInitialization
{
    NSArray *supportedClasses = [[LDPropertyMap defaultPropertyMap] supportedClasses];
    STAssertNotNil(supportedClasses, @"supported classes is nil");
    STAssertTrue([supportedClasses count]>0,@"supported classes should have atlease one entry");
    
    for(Class c in supportedClasses)
    {
        id instance = [[c alloc] init];
        STAssertNotNil(instance, @"could not instantiate object of class %@",c);
    }
}

-(void)testPropertyReadExistingValueForAllProperties
{
    
    NSArray *supportedClasses = [[LDPropertyMap defaultPropertyMap] supportedClasses];
    
    for(Class c in supportedClasses)
    {
        id instance = [[c alloc] init];
        NSArray *properties =  [[LDPropertyMap defaultPropertyMap] propertiesForObject:instance];
        for(LDProperty *property in properties)
        {
            STAssertNoThrow( [property readExistingValueFromObject:instance], @"Property could not be read");
        }
        
    }
}

-(void)testPropertySetOnObjectForAllProperties
{
    NSArray *supportedClasses = [[LDPropertyMap defaultPropertyMap] supportedClasses];
    
    for(Class c in supportedClasses)
    {
       // STAssertNoThrow([[c alloc] init], @"could not instantiate object of class %@",c);
        id instance = [[c alloc] init];
        NSArray *properties =  [[LDPropertyMap defaultPropertyMap] propertiesForObject:instance];
        for(LDProperty *property in properties)
        {
            STAssertNoThrow([property setOnObject:instance], @"Property not set");           
        }
        
    }
}


-(void)testPropertyMap
{
    STAssertNotNil(propertyMap, @"default property map cannot be nil");
}

-(void)testPropertyMapAddProperty
{
    //test add property
 
    UIView *viewInstance = [[UIView alloc] init];
    [propertyMap addProperty:dummyProperty forClass:[UIView class]];
    NSArray *properties = [propertyMap propertiesForObject:viewInstance];
    LDProperty *propertyJustInserted = nil;
    for(LDProperty *p in properties)
    {
        if (p.name == dummyProperty.name) {
            propertyJustInserted = p;
            break;
        }
    }
    STAssertNotNil(propertyJustInserted, @"property added but could not be retrieved");
}

-(void)testPropertyMapRemoveProperty
{
    //test remove property
    [propertyMap removePropertyWithName:dummyProperty.name forClass:[UIView class]];
    NSArray *properties = [propertyMap propertiesForObject:[UIView class]];
    LDProperty *propertyJustremoved = nil;
    for(LDProperty *p in properties)
    {
        if (p.name == dummyProperty.name) {
            propertyJustremoved = p;
            break;
        }
    }
    STAssertNil(propertyJustremoved, @"property was removed but still can be retrieved");
}

-(void)testPropertyMapRemoveClass
{
    //test remove
    [propertyMap removeSupportedClass:[UIView class]];
    UIView *viewInstance = [[UIView alloc] init];
    NSArray *properties = [propertyMap propertiesForObject:viewInstance];
    STAssertTrue((properties == nil || [properties count] == 0),@"class was removed but properties are still returned");

}



@end
