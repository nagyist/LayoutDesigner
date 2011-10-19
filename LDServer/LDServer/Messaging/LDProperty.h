//
//  Property.h
//  LaMo
//
//  Created by Ved Surtani on 13/09/11.
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


/*! @defgroup LDPropertyNotifications */
/*! @{ */
/*!
 @var           LDNewMessageSentNotification
 @brief         Notification that is posted when a new message is sent to a client object.
 @details       Whenever any operation by user leads to a proprty modified on the remote object (usually a view) on iPhone, this notification is raised.
 */
extern NSString* const LDPropertyChangedNotification;


/*!
 @var           LDPropertyChangedNotificationPropertyInstanceKey
 @brief         Key name for obtaining the @ref LDProperty object from the notification's userInfo
 dictionary
 */
extern NSString* const LDPropertyChangedNotificationPropertyInstanceKey;

/*! @} */




@interface LDProperty : NSObject<NSCoding,LMMessageParamDelegate>
{
    NSString *name;
    NSString *getter;
    NSString *setter;
    
    LDMessageParam  *param;
    LDMessageParam *originalParam;
    LDView *selectedView;
    

    
}

@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *getter;
@property(nonatomic,retain)NSString *setter;
@property(nonatomic,retain)LDMessageParam *param;
@property(nonatomic,retain)LDView *selectedView;
/*!
 @property      dirty
 @brief         true if the value was modified from the server, false otherwise.
 @details       this value is true IF the value was modified. Refreshing the view tree will reload values from the device and this will be set to false.
 */
@property(nonatomic,getter = isDirty)BOOL dirty;

-(void)populateControls:(NSView*)viewToBeUpdated;

/*!
 @brief     returns the code for setting the propertyValue to latest value.
 */
-(NSString*)getCode;
@end

