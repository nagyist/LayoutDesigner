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


@interface MainViewController : NSViewController<NSOutlineViewDelegate,NSOutlineViewDataSource,NSComboBoxDelegate,NSComboBoxDataSource>
{
    LDView *viewTreeRoot;
    LDView *selectedItem;
    LDHost *host;
   
}
@property(nonatomic,strong)LDView *viewTreeRoot;
@property (assign) IBOutlet OutlineViewWithKeyDownHandling *viewTreeOutlineView;
@property (assign) IBOutlet NSButton *refreshButton;
@property (assign) IBOutlet NSComboBox *optionsBox;
@property (assign) IBOutlet NSComboBox *actionsBox;
@property (assign) IBOutlet NSScrollView *controlViewContainer;

- (IBAction)optionsBoxValueChanged:(id)sender;
- (IBAction)refreshButtonClicked:(id)sender;

-(void)selectViewWithIdentifier:(LDView*)anItem;

@end
