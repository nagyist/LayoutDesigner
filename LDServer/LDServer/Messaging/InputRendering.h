//
//  InputRendering.h
//  LDServer
//
//  Created by Ved Surtani on 05/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ControlView.h"
@protocol InputRendering <NSObject>
-(ControlView*)viewForCollectingData;
@end
