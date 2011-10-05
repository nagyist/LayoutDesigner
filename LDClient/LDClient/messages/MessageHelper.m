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

@implementation MessageHelper

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
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
        LDMessageParamString *param = [[LDMessageParamString alloc] init];
        param.displayName = @"text";
        LDProperty *property =     [LDProperty propertyWithName:@"text" param:param];
        [property readExistingValueFromObject:aLabel];
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
