
//
//  Created by Ved Surtani on 03/11/11.
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
