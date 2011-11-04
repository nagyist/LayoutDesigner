//
//  SubviewTree.h
//  LayoutModifier
//
//  Created by Ved Surtani on 17/08/11.
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
#import <Cocoa/Cocoa.h>
#import "Tree.h"
@interface LDView : NSObject<NSCoding,TreeNode>
{
    NSString *name;
    NSInteger identifier;
    CGRect frame;
    NSArray *messages;
    NSMutableArray *children;
    NSArray *properties;
    
}
@property(nonatomic,retain)NSString *name;
@property(nonatomic)NSInteger identifier;
@property(nonatomic,retain)NSMutableArray *children;
@property(nonatomic,retain)NSArray *messages;
@property(nonatomic,strong)NSArray *properties;

@property(nonatomic)CGRect frame;
@end
