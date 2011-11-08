//
//  InputViewMap.m
//  LDServer
//
//  Created by Ved Surtani on 07/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "InputViewMap.h"
#import "FrameControlView.h"
#import "CGRectAdapter.h"
#import "ColorControlView.h"
#import "UIColorAdapter.h"
#import "EnumAdapter.h"
#import "EnumControlView.h"
#import "FloatAdapter.h"
#import "FloatControlView.h"
#import "ImageControlView.h"
#import "UIImageAdapter.h"
#import "StringControlView.h"
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
        NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"FrameControl" bundle:nil];
        FrameControlView *view =(FrameControlView*) viewController.view;
        [defaultMap setView:view forType:[CGRectAdapter class]];
    }
    
    {
        NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"ColorControl" bundle:nil];
        ColorControlView   *view = (ColorControlView*)viewController.view;
        [defaultMap setView:view forType:[UIColorAdapter class]];
    }
    
    {
        NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"EnumControl" bundle:nil];
        EnumControlView   *view = (EnumControlView*)viewController.view;
        [defaultMap setView:view forType:[EnumAdapter class]];
    }
    
    {
        NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"FloatControlView" bundle:nil];
        FloatControlView   *view = (FloatControlView*)viewController.view;
        [defaultMap setView:view forType:[FloatAdapter class]];
    }
    
    {
        NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"ImageControl" bundle:nil];
        ImageControlView   *view = (ImageControlView*)viewController.view;
        [defaultMap setView:view forType:[UIImageAdapter class]];
    }
    
    {
        NSViewController *viewController = [[NSViewController alloc] initWithNibName:@"StringControl" bundle:nil];
        StringControlView   *view = (StringControlView*)viewController.view;
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

-(void)setView:(ControlView*)view forType:(Class)type{
    [dictionaryOfInputViews setObject:view forKey:type];
}

-(ControlView*)viewForType:(Class)type
{
    return [dictionaryOfInputViews objectForKey:type];
}
@end
