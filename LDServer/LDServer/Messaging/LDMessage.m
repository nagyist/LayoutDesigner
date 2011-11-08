//
//  Message.m
//  LaMo
//
//  Created by Ved Surtani on 05/09/11.
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

#import "LDMessage.h"
#import "LDHost.h"
#import "LDMessageParam.h"
#import "InputViewMap.h"

NSString* const LDMessageSentNotification    = @"LDNewMessageSentNotification";
NSString* const LDMessageNotificationMessageInstanceKey    = @"LDNewMessageNotificationMessageInstanceKey";


@interface LDMessage(Private)
-(void)despatchNotification;
@end


@implementation LDMessage
@synthesize displayName,params,selectorAsString,selectedView;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    [self init];
    self.displayName = [aDecoder decodeObjectForKey:@"displayName"];
    self.params = [[aDecoder decodeObjectForKey:@"params"] copy];
    self.selectorAsString   = [aDecoder decodeObjectForKey:@"selector"];
    return  self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    NSLog(@"Encoding Message");
    [aCoder encodeObject:self.displayName forKey:@"displayName"];
    [aCoder encodeObject:params forKey:@"params"];
    [aCoder encodeObject:selectorAsString forKey:@"selector"];
     NSLog(@"Encoded Message");
}

+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s params:(NSArray*)params
{
    LDMessage *m =[[LDMessage alloc] init];
    m.displayName = n;
    m.params = params;
    m.selectorAsString = s;
    return [m autorelease];
}

+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s param:(id)param
{
    LDMessage *m =[[LDMessage alloc] init];
    m.displayName = n;
    m.params = [NSArray arrayWithObject:param];
    m.selectorAsString = s;
    return [m autorelease];
}
+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s param:(id)param param:(id)p2
{
    LDMessage *m =[[LDMessage alloc] init];
    m.displayName = n;
    m.params = [NSArray arrayWithObjects:param,p2,nil];
    m.selectorAsString = s;
    return [m autorelease];
}


-(void)populateControls:(NSView*)viewToBeUpdated
{
   
    for(NSView *v in [viewToBeUpdated subviews])
    {
        if ([v conformsToProtocol:@protocol(InputView)]) {
            [v removeFromSuperview];
        }
    }
    NSRect frame;

    int index = 0;
    if (params != nil) {
        for (LDMessageParam* aParam in params) {
            aParam.delegate = self;
            NSView<InputView> *aView = [[InputViewMap defaultMap] viewForType:[aParam.value class]];
            if (index++ == 0) {
                frame = aView.frame;
            }
            [viewToBeUpdated addSubview:aView];
            frame.origin.y += frame.size.height +20;
        }
    }
}


-(void)valueChanged:(LDMessageParam*)param
{
    NSMutableDictionary *packet = [[NSMutableDictionary alloc] init];
    [packet setObject:[NSString stringWithFormat:@"%d",selectedView.identifier] forKey:@"id"];
    [packet setObject:self forKey:@"exc"];
    
    [[LDHost sharedInstance] broadcastPacket:packet];
    [self despatchNotification];
    NSLog([self getCode]);
}

-(NSString*)getCode
{
    if(self.selectedView == nil)
    {
        return @"selectedView is nil. Cannot generate LHS code.";
    }
    //this will break the selector into parts for each parameter
    NSArray *tokenizedSelectorStrings = [selectorAsString componentsSeparatedByString:@":"];

    //where oneLine code will be saved
    NSMutableString * code = [[[NSMutableString alloc] init] autorelease];
    
    int index = 0;
    for(LDMessageParam *param in params){
        NSString *codeForParam = param.getCode;
        [code appendString:[NSString stringWithFormat:@"%@:%@",[tokenizedSelectorStrings objectAtIndex:index],codeForParam]];
    }
    
    return [NSString stringWithFormat:@"[%@ %@];",selectedView.name,code];
}

-(void)despatchNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LDMessageSentNotification object:nil userInfo:[NSDictionary dictionaryWithObject:self forKey:LDMessageNotificationMessageInstanceKey]];
}


-(void)dealloc
{
    [selectorAsString release];
    [displayName release];
    [params release];
    [super dealloc];
    
}
@end
