//
//  LogViewController.m
//  LDServer
//
//  Created by Ved Surtani on 17/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LogViewController.h"
#import "Logger.h"

@implementation LogViewController
@synthesize textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    
    return self;
}


-(void)logger:(Logger*)logger receivedNewLog:(LogMessage*)log
{
    NSRange range;
    range = NSMakeRange ([[textView string] length], 0);
    [textView replaceCharactersInRange: range withString: @"\n"];
    range = NSMakeRange ([[textView string] length], 0);
    [textView replaceCharactersInRange: range withString: log.text];
}


-(void)removeLastLog
{
    NSString *logText = [textView string];
    NSRange range;
    range = [logText rangeOfString:@"\n" options:NSBackwardsSearch];
    [textView replaceCharactersInRange:NSMakeRange(range.location, logText.length - range.location) withString:@""];
}

@end
