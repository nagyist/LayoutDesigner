//
//  Message.h
//  LaMo
//
//  Created by Ved Surtani on 05/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDMessage : NSObject<NSCoding>

{
    NSString *displayName;
    NSString *selectorAsString;
    NSArray *params;
}
@property(nonatomic,strong)NSString *displayName;
@property(nonatomic,strong)NSString *selectorAsString;
@property(nonatomic,strong)NSArray *params;


+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s params:(NSArray*)params;
+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s param:(id)param;
+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s param:(id)param param:(id)p2;


-(void)executeOnObject:(id)object;
-(void)executeOnObject:(id)object returnVal:(void*)returnVal;
-(NSInvocation*)invocationForObject:(id)object;

@end
