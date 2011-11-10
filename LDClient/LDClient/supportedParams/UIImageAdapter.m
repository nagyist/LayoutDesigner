//
//  LMMessageParamImage.m
//  LaMo
//
//  Created by Ved Surtani on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImageAdapter.h"

@implementation UIImageAdapter
@synthesize imageData;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeDataObject:imageData];

}

-(id)initWithCoder:(NSCoder *)aDecoder
{
   self =   [super init];
    self.imageData = [aDecoder decodeDataObject];
    return  self;
}



-(void*)value
{
    image = [[UIImage alloc] initWithData:imageData];
    return &image;
}

-(id)copyWithZone:(NSZone *)zone
{
    UIImageAdapter  *copy = [[UIImageAdapter alloc] init];
    copy.imageData = imageData;
    return copy;
}

@end
