//
//  FrameControlView.m
//  MacApplicationTest
//
//  Created by Ved Surtani on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FrameControlView.h"
#import "LDMessage.h"

@interface FrameControlView (Private)
-(void)addMouseEventHandler;
-(void)valueChanged;
@end

@implementation FrameControlView
@synthesize xField;
@synthesize yField;
@synthesize wField;
@synthesize hField;
@synthesize nameLabel;
@synthesize sendButton;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
-(void)awakeFromNib
{
   
}
- (void)drawRect:(NSRect)dirtyRect
{
    
}
-(void)viewWillDraw
{
    [self cleanup];
    [self addMouseEventHandler];
}
-(void)cleanup{
    if (mouseHandler != nil) {
        [NSEvent removeMonitor:mouseHandler];
    }
}

- (IBAction)send:(id)sender {
    [self valueChanged];
}



-(void)addMouseEventHandler
{
    
   
    monitorHandler = ^NSEvent * (NSEvent * theEvent){
        CGFloat deltaX =     [theEvent deltaX];
        CGFloat deltaY = [theEvent deltaY];
        [self incrementTextField:xField byVal:deltaX];
        [self incrementTextField:yField byVal:deltaY];

        [self valueChanged];
        
        return theEvent;
    };
     mouseHandler = [NSEvent addLocalMonitorForEventsMatchingMask:NSLeftMouseDraggedMask
                                                        handler:monitorHandler];
}

-(void)incrementTextField:(NSTextField*)tf byVal:(float)val
{
    float newVal = [tf floatValue];
    newVal += val;
    [tf setTitleWithMnemonic:[NSString stringWithFormat:@"%f",newVal]];
    
}

-(void)valueChanged
{
    if (delegate != nil) {
        [delegate valueChanged:self];
    }
 
}

@end
