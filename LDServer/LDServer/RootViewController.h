//
//  MainViewController.h
//  LDServer
//
//  Created by Ved Surtani on 19/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainViewController.h"
@interface RootViewController : NSViewController
@property (assign) IBOutlet NSTabView *tabView;
@property(nonatomic,readonly)MainViewController *viewControllerForClientMainScreen;

@end
