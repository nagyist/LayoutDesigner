//
//  LogMessage.m
//  LDServer
//
//  Created by Ved Surtani on 17/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LogMessage.h"


@interface LogMessage (Private)
-(void)setText:(NSString*)text_;
-(void)setTimeStamp:(NSString*)timestamp_;
@end

@implementation LogMessage
@synthesize text,timeStamp;
+(LogMessage*)createLogWithText:(NSString*)text_
{
    LogMessage *log = [[LogMessage alloc] init];
    [log setText:text_];
    [log setTimeStamp:[[NSDate date] description]];
    return [log autorelease];
}


-(void)setText:(NSString *)text_
{
    if (text_ == nil) {
        [text release];
        text = nil;
        return;
    }
    
    NSString *temp = text;
    text = [text_ copy];
    [temp release];
}

-(void)setTimeStamp:(NSString *)timestamp_
{
    if (timestamp_ == nil) {
        [timeStamp release];
        timeStamp = nil;
        return;
    }
    
    NSString *temp = timeStamp;
    timeStamp = [timestamp_ copy];
    [temp release];
}


-(void)dealloc
{
    [text release];
    [timeStamp release];
    [super dealloc];
}
@end
