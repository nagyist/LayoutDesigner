//
//  Logger.h
//  LDServer
//
//  Created by Ved Surtani on 17/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogMessage.h"
@protocol LoggerDelegate;
/*!
 @interface     Logger
 @brief         This class provides a ViewController for showing logs and methods for logging that show up in Logger's view
 @details       Instance of this class listens to notifications from @ref LDMessage and @ref LDProperty for changes and logs the generated code.
 */
@interface Logger : NSObject
{
   
    NSString *name;
    
    @private
    NSMutableArray *arrayOfLogs;
    NSViewController<LoggerDelegate> *mViewController;
    id previousObject; //message or property logged previously. This is used for consolidating logs if same property is modified several times.
}

/*!
 @brief     returns the  sharedInstance
 */
+(Logger*)sharedInstance;


/*!
 @param     logMessage message to add in the log window
 @brief     appends the logMessage to existing logMessages.
 */
-(void)log:(NSString*)logMessage;



/*!
 @brief     returns all the logged messages.
 @return    NSArray array of log messages.
 */
-(NSArray*)getLogs;


//for the timebeing this will be default so readOnly!!
@property(weak,readonly) NSViewController<LoggerDelegate> *mViewController;

@end


/*!
 @protocol      LoggerDelegate
 @brief         
 */
@protocol LoggerDelegate <NSObject>
@required
/*!
 @brief     notifies the delegate that a new log was received by logger.
 */
-(void)logger:(Logger*)logger receivedNewLog:(LogMessage*)log;

/*!
 @brief     notifies the delegate that last log should be removed
 @details   This gets called when a log consolidation is happening. Example same property is modified and the logger receives multiple calls to log the
 the change in same property. Logger decides to consolidate logs into one log and hences asks the delegate sequentially to remove the last log.
 */
-(void)removeLastLog;
@end
