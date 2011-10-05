//
//  Message.m
//  LaMo
//
//  Created by Ved Surtani on 05/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LDMessage.h"
#import "LDMessageParam.h"
@implementation LDMessage
@synthesize displayName,params,selectorAsString;
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
    self = [self init];
    self.displayName = [aDecoder decodeObjectForKey:@"displayName"];
    self.params = [aDecoder decodeObjectForKey:@"params"];
    self.selectorAsString   = [aDecoder decodeObjectForKey:@"selector"];
    return  self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.displayName forKey:@"displayName"];
    [aCoder encodeObject:self.params forKey:@"params"];
    [aCoder encodeObject:self.selectorAsString forKey:@"selector"];
}

-(void)executeOnObject:(id)object
{
    NSInvocation *anInvocation = [self invocationForObject:object];
    [anInvocation invoke];
    
}

-(void)executeOnObject:(id)object returnVal:(void*)returnVal
{
    NSInvocation *anInvocation = [self invocationForObject:object];
    [anInvocation invoke];
    [anInvocation getReturnValue:returnVal];
}

-(NSInvocation*)invocationForObject:(id)object
{
    SEL selector = NSSelectorFromString(selectorAsString);
    NSMethodSignature *methodSignature = [[object class] instanceMethodSignatureForSelector:selector];
    NSInvocation *anInvocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [anInvocation setSelector:selector];
    [anInvocation setTarget:object];
    
    if (params != nil) {
        for(int i=0;i<[params count];i++)
        {
            LDMessageParam *param = [params objectAtIndex:i];
            void *val = [param value];
            [anInvocation setArgument:val atIndex:i+2];
        }
    }
    
    return anInvocation;

}


+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s params:(NSArray*)params
{
    LDMessage *m =[[LDMessage alloc] init];
    m.displayName = n;
    m.params = params;
    m.selectorAsString = s;
    return m;
}

+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s param:(id)param
{
    LDMessage *m =[[LDMessage alloc] init];
    m.displayName = n;
    m.params = [NSArray arrayWithObject:param];
      m.selectorAsString = s;
    return m;
}
+(LDMessage*)messageWithName:(NSString*)n selector:(NSString*)s param:(id)param param:(id)p2
{
    LDMessage *m =[[LDMessage alloc] init];
    m.displayName = n;
    m.params = [NSArray arrayWithObjects:param,p2,nil];
      m.selectorAsString = s;
    return m;
}



@end
