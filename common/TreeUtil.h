//
//  TreeUtil.h
//  LDServer
//
//  Created by Ved Surtani on 03/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tree.h"

@interface TreeUtil : NSObject
+(NSArray*)allParentsOfNode:(id<TreeNode>)node inTreeRootedAt:(id<TreeNode>)root;
+(id<TreeNode>)findNode:(NSInteger)identifier inTreeRootedAt:(id<TreeNode>)root;
@end
