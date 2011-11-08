//
//  LMRootViewController.h
//  LayoutModifierServer
//
//  Created by Ved Surtani on 03/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OutlineViewWithKeyDownHandling.h"
#import "LDHost.h"
#import "LDView.h"
#import "InputView.h"
#import "LDMessage.h"
#import "LDCommand.h"


@interface MainViewController : NSViewController<NSOutlineViewDelegate,NSOutlineViewDataSource,LMHostDelegate,NSComboBoxDelegate,NSComboBoxDataSource>
{
    LDView *subviewRoot;
    LDView *selectedItem;
    LDHost *host;
   
}
@property (assign) IBOutlet OutlineViewWithKeyDownHandling *viewTreeOutlineView;
@property (assign) IBOutlet NSButton *refreshButton;
@property (assign) IBOutlet NSComboBox *optionsBox;
@property (assign) IBOutlet NSComboBox *actionsBox;
@property (assign) IBOutlet NSScrollView *controlViewContainer;

- (IBAction)optionsBoxValueChanged:(id)sender;
- (IBAction)refreshButtonClicked:(id)sender;

@property (assign) IBOutlet NSWindow *logWindow;
- (IBAction)showLogButtonClicked:(id)sender;

-(void)sendHighlightForViewId:(NSInteger)viewId;


-(LDView*)viewForId:(NSInteger)anIdentifier inRoot:(LDView*)aRoot;
@end
