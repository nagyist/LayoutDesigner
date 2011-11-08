//
//  FrameControlView.m
//  MacApplicationTest
//
//  Created by Ved Surtani on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CGRectInputView.h"
#import "LDMessage.h"
#import "CGRectAdapter.h"
@interface CGRectInputView (Private)
-(void)addMouseEventHandler;
-(void)valueChanged;
@end

@implementation CGRectInputView
@synthesize xField;
@synthesize yField;
@synthesize wField;
@synthesize hField;
@synthesize nameLabel;
@synthesize sendButton;
@synthesize  delegate;
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

#pragma mark -
#pragma InputView protocol
-(void)setInitialValue:(id<TypeAdapter>)initialValue
{
    NSParameterAssert([initialValue isKindOfClass:[CGRectAdapter class]]);
    CGRect frame = [(CGRectAdapter*)initialValue rect];
    [xField setTitleWithMnemonic:[NSString stringWithFormat:@"%f",frame.origin.x]];
    [yField setTitleWithMnemonic:[NSString stringWithFormat:@"%f",frame.origin.y]];
    [wField setTitleWithMnemonic:[NSString stringWithFormat:@"%f",frame.size.width]];
    [hField setTitleWithMnemonic:[NSString stringWithFormat:@"%f",frame.size.height]];
    
}

-(id<TypeAdapter>)getValue
{
    CGRectAdapter *value = [[CGRectAdapter alloc] init];
    CGFloat x = [xField floatValue];
    CGFloat y = [yField floatValue];
    CGFloat w = [wField floatValue];
    CGFloat h = [hField floatValue];
    value.rect = CGRectMake(x,y , w, h);
    return [value autorelease];
}


@end
