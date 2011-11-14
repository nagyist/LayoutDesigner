//
//  ViewTreeManager.h
//  LDClient
//
//  Created by Ved Surtani on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDView.h"
@interface ViewTreeManager : NSObject
{
    @private
    NSMutableArray *viewTrees;
    NSMutableArray *gestureRecognizersForViewTrees;
}
+(ViewTreeManager*)sharedInstance;
//public
-(LDView*)viewTreeForWithRootId:(NSInteger)identifier;
-(LDView*)createViewTreeForApplicationWindow;
//private
-(LDView*)createViewTreeWithRootView:(UIView*)aView;
-(void)removeViewTreeWithRootId:(NSInteger)identifier;
@end
