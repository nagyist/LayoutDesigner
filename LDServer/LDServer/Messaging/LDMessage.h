//
//  Message.h
//  LaMo
//
//  Created by Ved Surtani on 05/09/11.
//  Copyright 2011 Imaginea 
//  Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at

//  http://www.apache.org/licenses/LICENSE-2.0

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.




#import <Foundation/Foundation.h>
#import "LDMessageParam.h"
#import "LDView.h"

/*! @defgroup LDMessageNotifications */
/*! @{ */
/*!
 @var           LDNewMessageSentNotification
 @brief         Notification that is posted when a new message is sent to a client object.
 @details       Whenever any operation by user leads to a message beign sent to the remote object (usually a view) on iPhone, this notification is raised.
 */
extern NSString* const LDMessageSentNotification;


/*!
 @var           LDNewMessageNotificationMessageInstanceKey
 @brief         Key name for obtaining the @ref LDMessage object from the notification's userInfo
 dictionary
 */
extern NSString* const LDMessageNotificationMessageInstanceKey;

/*! @} */

@interface LDMessage : NSObject<NSCoding,LMMessageParamDelegate>

{
    NSString *displayName;
    NSString *selectorAsString;
    NSArray *params;
    
    LDView *selectedView  ;
}
@property(nonatomic,retain)NSString *displayName;
@property(nonatomic,retain)NSString *selectorAsString;
@property(nonatomic,retain)NSArray *params;
@property(nonatomic,assign)LDView *selectedView;

+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s params:(NSArray*)params;
+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s param:(id)param;
+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s param:(id)param param:(id)p2;


-(void)populateControls:(NSView*)viewToBeUpdated;


/*!
 @brief     returns the code for setting the propertyValue to latest value.
 */
-(NSString*)getCode;
@end
