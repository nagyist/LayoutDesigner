//
//  SubviewTree.h
//  LayoutModifier
//
//  Created by Ved Surtani on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDCommandMap.h"
#import "TreeNode.h"
@protocol TreeNode;

@interface LDView : NSObject<NSCoding,TreeNode>
//@interface LDView: NSObject 
{

    UIView *__weak view;
    NSString *name;
    NSInteger identifier;
    CGRect frame;
    NSMutableArray *children;
    NSArray *messages;
    NSArray *properties;
    
}
@property(nonatomic,strong)NSString *name;
@property(nonatomic)NSInteger identifier;
@property(nonatomic,weak)UIView *view;
@property(nonatomic,strong)NSMutableArray *children;
@property(nonatomic)CGRect frame;
@property(nonatomic,strong)NSArray *messages;
@property(nonatomic,strong)NSArray *properties;
@end
