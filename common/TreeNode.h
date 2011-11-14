//
//  Tree.h
//  LDServer
//
//  Created by Ved Surtani on 03/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @protocol      TreeNode
 @brief         Protocol for Tree implementations.
 */
@protocol TreeNode <NSObject>
@required
-(NSInteger)identifier;
-(NSArray*)children;
@end
