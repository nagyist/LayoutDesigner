//
//  Command.h
//  LayoutModifier
//
//  Created by Ved Surtani on 24/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
static const int default_SendListOfCommands = 0;

extern const NSInteger serverCommandSendViewUpdate;

@interface LDCommand : NSObject
{
    NSInteger identifier;
    NSString *displayName;
    NSString *selectorName;
    id __weak target; // default is always RemoteService
}

@property(nonatomic,strong)NSString *displayName;
@property(nonatomic,strong)NSString *selectorName;
@property(nonatomic,weak)id target;
@property(nonatomic)NSInteger identifier;

+(LDCommand*)createNewCommandWithDisplayName:(NSString*)dName selectorName:(NSString*)sName target:(id)target;
-(BOOL)executeWithObject:(id)object_;
+(LDCommand*)commandWithIdentifier:(NSInteger)identifier_;
+(NSArray*)allCommands;
@end
