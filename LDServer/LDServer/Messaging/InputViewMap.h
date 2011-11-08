//
//  InputViewMap.h
//  LDServer
//
//  Created by Ved Surtani on 07/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InputView.h"
@interface InputViewMap : NSObject
{
    @private
    NSMutableDictionary *dictionaryOfInputViews;
}
+(InputViewMap*)defaultMap;
+(void)setDefaultMap:(InputViewMap*)map;
-(void)setView:(NSView<InputView>*)view forType:(Class)type;
-(NSView<InputView>*)viewForType:(Class)type;
@end
