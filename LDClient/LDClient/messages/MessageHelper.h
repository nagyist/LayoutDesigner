//
//  MessageHelper.h
//  LaMo
//
//  Created by Ved Surtani on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDMessageParam.h"
#import "LDMessageParamCGRect.h"
#import "LDMessageParamColor.h"
#import "LDMessageParamEnum.h"
#import "LDMessageParamFloat.h"
#import "LDMessageParamFloat.h"
#import "LDMessageParamInt.h"
#import "LDMessageParamString.h"
#import "LDMessageParamImage.h"
#import "LDMessage.h"
#import <QuartzCore/QuartzCore.h>
@interface MessageHelper : NSObject
{
   
}
@property(weak)id targetObject;


+(NSArray*)propertiesForObject:(id)object;
+(NSArray*)messagesForObject:(id)object;
+(NSArray*)messagesForUIView:(UIView*)aView;
+(NSArray*)messagesForUILabel:(UILabel*)aLabel;
+(NSArray*)messagesForUIImageView:(UIImageView*)anImageView;
@end
