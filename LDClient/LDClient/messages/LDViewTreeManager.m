//
//  LDViewTreeManager.m
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

#import "LDViewTreeManager.h"
#import "RemoteService.h"
static LDViewTreeManager *sharedInstance;

@interface LDViewTreeManager(Private)
-(id)initPrivate;
-(LDView*)getTouchedViewIn:(LDView*)rootView sender:(UIGestureRecognizer*)sender;
-(BOOL)shouldGoInside:(UIView*)view;
@end

@implementation LDViewTreeManager


+(LDViewTreeManager*)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[LDViewTreeManager alloc] initPrivate];
    }
    return sharedInstance;
}

-(id)initPrivate
{
    self = [super init];
    viewTrees = [[NSMutableArray alloc] init];
    gestureRecognizersForViewTrees = [[NSMutableArray alloc] init];
    return self;
}

-(id)init{
    NSAssert(NO,@"Cannot instantiate this directly, use sharedInstance");
    return self;// for warning
}


-(LDView*)viewTreeForWithRootId:(NSInteger)identifier
{
    NSArray *copyOfViewTrees = [viewTrees copy];
    for(LDView *root in copyOfViewTrees)
    {
        if (root.identifier == identifier) {
            return root;
        }
    }
    return nil;
}

-(LDView*)createViewTreeWithRootView:(UIView*)aView
{
    LDView *newViewTree = [[LDView   alloc] init];
    [newViewTree setView:aView];
    [viewTrees addObject:newViewTree];
    
    //add gesture recognizer for this view
    UIGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTapped:)];
    [aView addGestureRecognizer:gestureRecognizer];
    [gestureRecognizersForViewTrees addObject:gestureRecognizer];
    
    return newViewTree;
}

-(LDView*)createViewTreeForApplicationWindow
{
    UIWindow *appWindow = [[[UIApplication sharedApplication]delegate] window];
    //remove the tree with application wondow first
    NSArray *copyOfViewTrees = [viewTrees copy];
    for(LDView *root in copyOfViewTrees)
    {
        if (root.view == appWindow) {
            [self removeViewTreeWithRootId:root.identifier];
            break;
        }
    }
    
    return [self createViewTreeWithRootView:appWindow];
}

-(void)removeViewTreeWithRootId:(NSInteger)identifier
{
     NSArray *copyOfViewTrees = [viewTrees copy];
    for(LDView *root in copyOfViewTrees )
    {
        if (root.identifier == identifier) {
            [gestureRecognizersForViewTrees removeObjectAtIndex:[viewTrees indexOfObject:root]];
            [viewTrees removeObject:root];
        }
    }
}


-(void)screenTapped:(UIGestureRecognizer*)sender
{
    //this is the point in Window
    // CGPoint point = [sender locationInView:root.view];
    NSUInteger indexOfSender = [gestureRecognizersForViewTrees indexOfObject:sender];
    
    LDView *root = [viewTrees objectAtIndex:indexOfSender];
    if (root != nil) {
        LDView * touchedView = [self getTouchedViewIn:root sender:sender];
        if (touchedView != nil) {
            NSLog(@"touched %@",[touchedView.view class]);
            [[RemoteService sharedInstance]sendSelectViewCommand:touchedView inViewTree:root];
        }
    }
    else{
        NSLog(@"Failed to send selectView command to server: root is null");
    }
    
    
}

//private gesture handle for selection from iphone side.
-(LDView*)getTouchedViewIn:(LDView*)rootView sender:(UIGestureRecognizer*)sender
{
    //this is the point in Window
    UIView *view = rootView.view;
    CGPoint point = [sender locationInView:view];
    if (point.x <0 || point.y < 0 || point.x > view.frame.size.width || point.y > view.frame.size.height) {
        return nil; //this was not touched
    }
    //touch is inside the view
    //find if any descendants contain the point
    //iterate from opposite end because last index is where the topmost subview is
    
    //but WAIT!! we don wanna go into internal iOS classes, so check if we wanna go inside or not!!!
    
    if ([self shouldGoInside:rootView.view] && rootView.children != nil) {
        for(int i=rootView.children.count -1; i>=0; i--)
        {
            LDView *subview = [rootView.children objectAtIndex:i];
            LDView *touchedSubview = [self getTouchedViewIn:subview sender:sender];
            if (touchedSubview != nil) {
                return touchedSubview;
            }
            
        }
    }
    return  rootView;
}

-(BOOL)shouldGoInside:(UIView*)view
{
    NSMutableArray *arrayOfClassNames = [[NSMutableArray alloc] init];
    [arrayOfClassNames addObject:[[UITextView class] description]];
    
    return !([arrayOfClassNames containsObject:[[view class] description]]);
}



@end
