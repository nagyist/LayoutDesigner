//
//  InputViewMap.h
//  LDServer
//
//  Created by Ved Surtani on 07/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ControlView.h"
@interface InputViewMap : NSObject
{
    @private
    NSMutableDictionary *dictionaryOfInputViews;
}
+(InputViewMap*)defaultMap;
+(void)setDefaultMap:(InputViewMap*)map;
-(void)setView:(ControlView*)view forType:(Class)type;
-(ControlView*)viewForType:(Class)type;
@end
