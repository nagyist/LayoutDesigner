//
//  LDViewTreeManager.h
//  LDClient
//
//  Created by Ved Surtani on 10/11/11.
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
#import "LDView.h"


/*!
 @class     LDViewTreeManager
 @brief     Singleton class, manages all the viewTrees that are being edited or accessed from remote LDServer.
 @details   Generally all the views, especially each window in the application will represent one view tree. View tree is a Root View with all it's subviews 
 with subviews having it's own tree of subviews. This is a manager class tht stores all such view trees that are being modified or accessed from LDServer.
 */
@interface LDViewTreeManager : NSObject
{
    @private
    NSMutableArray *viewTrees;
    NSMutableArray *gestureRecognizersForViewTrees;
}


/*!
 @brief     returns the singlton shared instance.
 */
+(LDViewTreeManager*)sharedInstance;

/*!
 @brief     returns the @ref LDView instance whose identifier is the one specifed.
 @param     identifier the identifier of the View that is rootview in the the tree.
 @details   This method returns the first node that is the root of the tree. See @ref LDView for understanding view trees.
 @ref       LDView
 */
-(LDView*)viewTreeForWithRootId:(NSInteger)identifier;

/*!
 @brief     creates the view tree using ApplicationDelegate's window.
 @details   This takes the application window and creates LDView instances for it and all it's subviews. The tree's root that is the @ref LDView instance 
 for the window is then stored and returned back.
 */
-(LDView*)createViewTreeForApplicationWindow;


/*!
 @brief     removes the tree with specfied identifier of the root from the manager.
 @param     identifier the identifier of the root view of the tree.
 */
-(void)removeViewTreeWithRootId:(NSInteger)identifier;
@end
