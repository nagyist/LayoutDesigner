//
//  LayerProperty.m
//  LaMo
//
//  Created by Ved Surtani on 04/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LDLayerProperty.h"

@implementation LDLayerProperty
-(NSString*)getCode
{
    
    if(self.selectedView == nil)
    {
        return @"selectedView is nil. Cannot generate LHS code.";
    }
    
    NSString *rhs = self.param.getCode;
    NSString *variableName = selectedView.name;
    NSString *code = [NSString stringWithFormat:@"[%@.layer %@%@];",variableName,self.setter,rhs];
    
    return code;
    
}

@end
