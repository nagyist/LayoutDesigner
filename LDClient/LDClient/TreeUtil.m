//
//  TreeUtil.m
//  LDServer
//
//  Created by Ved Surtani on 03/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TreeUtil.h"

@implementation TreeUtil

+(NSArray*)allParentsOfNode:(id<TreeNode>)node inTreeRootedAt:(id<TreeNode>)root
{
    //start finding form the root recursively
    NSArray *children = [root children];
    if([children containsObject:node])
        return [NSArray arrayWithObject:root];
    else{
        for(id<TreeNode> child in children)
        {
            NSArray *parents = [TreeUtil allParentsOfNode:node inTreeRootedAt:child];
            if(parents != nil)
            {
                NSMutableArray *parentsToReturn = [[NSMutableArray alloc] init];
                [parentsToReturn addObject:root];
                [parentsToReturn addObjectsFromArray:parents];
               //return [parentsToReturn autorelease]; //FIXIT: ARC only in client, put ifdef
               return parentsToReturn;
            }
        }
        
    }
    return nil;
}


+(id<TreeNode>)findNode:(NSInteger)identifier inTreeRootedAt:(id<TreeNode>)root
{
    if ([root identifier] == identifier)
        return root;
    else if([root children] != nil){
        for(id<TreeNode> child in [root children])
        {
            id<TreeNode> foundNode = [TreeUtil  findNode:identifier inTreeRootedAt:child];
            if (foundNode != nil) {
                return foundNode;
            }
        }
    }
    return nil;

}
@end
