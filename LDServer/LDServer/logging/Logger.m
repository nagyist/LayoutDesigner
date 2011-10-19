//
//  Logger.m
//  LDServer
//
//  Created by Ved Surtani on 17/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Logger.h"
#import "LogMessage.h"
#import "LogViewController.h"
#import "LDProperty.h"
#import "LDMessage.h"
static Logger *sharedInstance = nil;

@interface Logger()
-(id)initPrivate;
@end

@implementation Logger
@synthesize mViewController;


+(Logger*)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[Logger alloc] initPrivate];
    }
    return sharedInstance;
}



//crash the application
-(id)init
{
    NSAssert(false, @"Can't initiaze this instance directly. User the sharedInstance: class methd");
    return nil;

}

-(id)initPrivate
{
    self = [super init];
    arrayOfLogs = [[NSMutableArray alloc] init];
    
    //initialize the defaultViewController
    LogViewController *viewController = [[LogViewController alloc] initWithNibName:@"LogViewController" bundle:[NSBundle mainBundle]];
    mViewController = viewController;
    [viewController.textView setFont:[NSFont systemFontOfSize:16]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(propertyChanged:) name:LDPropertyChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newMessageSent:) name:LDMessageSentNotification object:nil];
    return self;
    
}

-(void)propertyChanged:(NSNotification*)notification
{
   LDProperty *property =  [[notification userInfo] objectForKey:LDPropertyChangedNotificationPropertyInstanceKey];
    
    
    if(property  == previousObject)
    {
       [mViewController removeLastLog];
    }
      previousObject = property;
    [self log:[property getCode]];
}

-(void)newMessageSent:(NSNotification*)notification
{
    LDMessage *message = [[notification userInfo] objectForKey:LDMessageNotificationMessageInstanceKey];
    if (previousObject == message)
    {
        [mViewController removeLastLog];
    }
    previousObject = message;
    [self log:[message getCode]];
}

-(void)log:(NSString*)logMessage
{
    [arrayOfLogs addObject:[LogMessage createLogWithText:logMessage]];
    if (mViewController != nil && [mViewController respondsToSelector:@selector(logger:receivedNewLog:)]) {
        [mViewController performSelector:@selector(logger:receivedNewLog:) withObject:self withObject:[LogMessage createLogWithText:logMessage]];
    }
    else
    {
        NSLog(@"No ViewController and Logger Delegate Set!!!!!");
    }
}

-(NSArray*)getLogs
{
    return [[arrayOfLogs copy] autorelease];
}



@end
