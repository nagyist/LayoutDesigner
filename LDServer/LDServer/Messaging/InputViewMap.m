//
//  InputViewMap.m
//  LDServer
//
//  Created by Ved Surtani on 07/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "InputViewMap.h"
#import "CGRectInputView.h"
#import "CGRectAdapter.h"
#import "UIColorInputView.h"
#import "UIColorAdapter.h"
#import "EnumAdapter.h"
#import "EnumInputView.h"
#import "FloatAdapter.h"
#import "FloatInputView.h"
#import "UIImageInputView.h"
#import "UIImageAdapter.h"
#import "NSStringInputView.h"
#import "NSStringAdapter.h"
#import "IntegerAdapter.h"
static InputViewMap *defaultMap = nil;
@implementation InputViewMap



+(InputViewMap*)defaultMap
{
    if(defaultMap != nil)
    {
        return defaultMap;
    }
    //setup defaultMap
    defaultMap = [[InputViewMap alloc] init];
    
    //create default input views for each type.
    {
        NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"CGRectInput" bundle:nil];
        CGRectInputView *view =(CGRectInputView*) viewController.view;
        [defaultMap setView:view forType:[CGRectAdapter class]];
    }
    
    {
        NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"UIColorInput" bundle:nil];
        UIColorInputView   *view = (UIColorInputView*)viewController.view;
        [defaultMap setView:view forType:[UIColorAdapter class]];
    }
    
    {
        NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"EnumInput" bundle:nil];
        EnumInputView   *view = (EnumInputView*)viewController.view;
        [defaultMap setView:view forType:[EnumAdapter class]];
    }
    
    {
        NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"FloatInput" bundle:nil];
        FloatInputView   *view = (FloatInputView*)viewController.view;
        [defaultMap setView:view forType:[FloatAdapter class]];
    }
    
    {
        NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"UIImageInput" bundle:nil];
        UIImageInputView   *view = (UIImageInputView*)viewController.view;
        [defaultMap setView:view forType:[UIImageAdapter class]];
    }
    
    {
        NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"NSStringInput" bundle:nil];
        NSStringInputView   *view = (NSStringInputView*)viewController.view;
        [defaultMap setView:view forType:[NSStringAdapter class]];
    }
    
    
    
    
    return defaultMap;
}

+(void)setDefaultMap:(InputViewMap*)map
{
    defaultMap = map;
}


-(id)init
{
    self = [super init];
    dictionaryOfInputViews = [[NSMutableDictionary alloc] init];
    return self;
}

-(void)dealloc
{
    [dictionaryOfInputViews release];
    [super dealloc];
}

-(void)setView:(NSView<InputView>*)view forType:(Class)type{
    [dictionaryOfInputViews setObject:view forKey:type];
}

-(NSView<InputView>*)viewForType:(Class)type
{
    return [dictionaryOfInputViews objectForKey:type];
}
@end
