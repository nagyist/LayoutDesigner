//
//  MessageHelper.m
//  LaMo
//
//  Created by Ved Surtani on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MessageHelper.h"
#import "LDProperty.h"
#import "LDLayerProperty.h"
#import "EnumHelper.h"
static NSMutableSet *supportedClasses;

@implementation MessageHelper
@synthesize targetObject;

+(void)initialize
{
    supportedClasses = [[NSMutableSet alloc] init];
    [supportedClasses addObject:[UIView class]];
    [supportedClasses addObject:[UILabel class]];
    [supportedClasses addObject:[UIImageView class]];
    
}
+(NSArray*)propertiesForObject:(id)object
{
    DLog(@"%@",object);
    NSMutableArray *properties = [[NSMutableArray alloc] init];
    MessageHelper *helper = [[MessageHelper alloc] init];
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

-(NSArray*)propertiesForUIView
{
    NSMutableArray *arrayOfProperties = [[NSMutableArray alloc] init];
    
    [arrayOfProperties addObject:[LDProperty propertyWithName:@"frame" type:[LDMessageParamCGRect class]]];
    [arrayOfProperties addObject:[LDProperty propertyWithName:@"backgroundColor" type:[LDMessageParamColor class]]];
    [arrayOfProperties addObject:[LDProperty propertyWithName:@"alpha" type:[LDMessageParamFloat class]]];
    [arrayOfProperties addObject:[LDLayerProperty propertyWithName:@"cornerRadius" type:[LDMessageParamFloat class]]];
    //TODO: test with testCase
   // [arrayOfProperties addObject:[LDLayerProperty propertyWithName:@"cornerRadiues" type:[LDMessageParamFloat class]]];
    return arrayOfProperties;
}

-(NSArray*)propertiesForUILabel
{
    NSMutableArray *arrayOfProperties = [[NSMutableArray alloc] init];
    
    [arrayOfProperties addObject:[LDProperty propertyWithName:@"text" type:[LDMessageParamString class]]];
    [arrayOfProperties addObject:[LDProperty propertyWithName:@"textColor" type:[LDMessageParamColor class]]];
    [arrayOfProperties addObject:[LDProperty propertyWithName:@"textAlignment" param:[EnumHelper enumForTextAlignment]]];
    return arrayOfProperties;
}

-(NSArray*)propertiesForUIImageView
{
    NSMutableArray *arrayOfProperties = [[NSMutableArray alloc] init];
    
    [arrayOfProperties addObject:[LDProperty propertyWithName:@"image" type:[LDMessageParamImage class]]];
    return arrayOfProperties;
}



+(NSArray*)messagesForObject:(id)object
{
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    
    if ([object isKindOfClass:[UIView class]]) {
        [messages addObjectsFromArray:[MessageHelper messagesForUIView:object]];
    }
    
    if ([object isKindOfClass:[UILabel class]]) {
        
        [messages addObjectsFromArray:[MessageHelper messagesForUILabel:object]];
    }
    
    if ([object isKindOfClass:[UIImageView class]]) {
        [messages addObjectsFromArray:[MessageHelper messagesForUIImageView:object]];
    }
    return messages;
}

+(NSArray*)messagesForUIView:(UIView*)aView
{
    NSMutableArray *arrayOfMessages = [[NSMutableArray alloc] init]; 
   
    //frame
    {
        LDMessageParamCGRect *param = [[LDMessageParamCGRect alloc] init];
        param.displayName = @"frame";
       param.rect = aView.frame;
        LDMessage *message = [LDMessage messageWithName:@"setFrame" selector:@"setFrame:" param:param];
        [arrayOfMessages addObject:message];
    }
    
    //backgroundColor
    {
        LDMessageParamColor *param = [[LDMessageParamColor alloc] init];
        param.displayName = @"background";
        LDMessage *message = [LDMessage messageWithName:@"setBackgroundColor" selector:@"setBackgroundColor:" param:param];
        [arrayOfMessages addObject:message];
    }
    
    //alpha
    {
        LDMessageParamFloat *param = [[LDMessageParamFloat alloc] init];
        param.displayName = @"View alpha";
        param.aFloat = aView.alpha;
        LDMessage *message = [LDMessage messageWithName:@"setAlpha" selector:@"setAlpha:" param:param];
        [arrayOfMessages addObject:message];
    }
    
    //corner radius
    {
        LDMessageParamFloat *param = [[LDMessageParamFloat alloc] init];
        LDLayerProperty *property = [LDLayerProperty propertyWithName:@"cornerRadius" param:param];
        [property readExistingValueFromObject:aView];
        [arrayOfMessages addObject:property];
    }
    
   
    return arrayOfMessages;
}





+(NSArray*)messagesForUILabel:(UILabel*)aLabel
{
    NSMutableArray *arrayOfMessages = [[NSMutableArray alloc] init];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:[LDMessageParamString class] forKey:@"text"];
    [dictionary setObject:[LDMessageParamEnum class] forKey:@"textAlignment"];
    [dictionary setObject:[LDMessageParamColor class] forKey:@"textColor"];
    
    
    //textColor
    {
        LDMessageParamColor *param = [[LDMessageParamColor alloc] init];
        param.displayName = @"textColor";
        LDMessage *message = [LDMessage messageWithName:@"setTextColor" selector:@"setTextColor:" param:param];
        [arrayOfMessages addObject:message];
    }
    
    
    //textAlignment
    {
        LDMessageParamEnum *param = [[LDMessageParamEnum alloc] init];
        param.displayName = @"textAlignment";
        param.displayNames = [NSArray arrayWithObjects:@"Left",@"Right",@"center", nil];
        param.integerValuesAsString = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",UITextAlignmentLeft],
                                       [NSString stringWithFormat:@"%d",UITextAlignmentRight],
                                       [NSString stringWithFormat:@"%d",UITextAlignmentCenter],nil];
        
        LDMessage *message = [LDMessage messageWithName:@"setTextAlignment" selector:@"setTextAlignment:" param:param];
        [arrayOfMessages addObject:message];
    }
    
    //text
    {
        //LDMessageParamString *param = [[LDMessageParamString alloc] init];
        //param.displayName = @"text";
  //      LDProperty *property =     [LDProperty propertyWithName:@"text" param:param];
        LDProperty *property = [LDProperty propertyWithName:@"text" type:[LDMessageParamString class] target:aLabel];
        //[property readExistingValueFromObject:aLabel];
        [arrayOfMessages addObject:property];
    }
    
    
    
    return arrayOfMessages;
}

+(NSArray*)messagesForUIImageView:(UIImageView*)anImageView
{
    NSMutableArray *arrayOfMessages = [[NSMutableArray alloc] init];
    
    //image
    {
        LDMessageParamImage *param = [[LDMessageParamImage alloc] init];
        param.displayName = @"image";
        LDMessage *message = [LDMessage messageWithName:@"setImage:" selector:@"setImage:" param:param];
        [arrayOfMessages addObject:message];
    }
    return  arrayOfMessages;

}
@end
