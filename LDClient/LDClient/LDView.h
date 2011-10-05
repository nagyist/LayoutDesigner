//
//  SubviewTree.h
//  LayoutModifier
//
//  Created by Ved Surtani on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LDView : NSObject<NSCoding>
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
