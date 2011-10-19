//
//  LogMessage.h
//  LDServer
//
//  Created by Ved Surtani on 17/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 @brief     Instances of this class represent an individual log message.
 */
@interface LogMessage : NSObject
{
    NSString *text;
    NSString *timeStamp;
}

/*!
 @param     text_ logText
 @brief     returns a LogMessage instance initialized with text and timestamp.
 @details   timestamp is generated at the time of creation.
 */
+(LogMessage*)createLogWithText:(NSString*)text_;


/*!
 @property      text
 @brief         log text
 */
@property(nonatomic,readonly)NSString *text;

/*!
 @property      timeStamp
 @brief         readable time string at which the log was created.
 */
@property(nonatomic,readonly)NSString *timeStamp;
@end
