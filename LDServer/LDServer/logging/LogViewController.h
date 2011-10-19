//
//  LogViewController.h
//  LDServer
//
//  Created by Ved Surtani on 17/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@protocol LoggerDelegate;
@interface LogViewController : NSViewController<LoggerDelegate>

@property (assign) IBOutlet NSTextView *textView;
@end
