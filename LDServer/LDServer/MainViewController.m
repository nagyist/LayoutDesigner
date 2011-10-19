//
//  LMRootViewController.m
//  LayoutModifierServer
//
//  Created by Ved Surtani on 03/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "LDProperty.h"
#import "Logger.h"
@implementation MainViewController
@synthesize logWindow;
@synthesize viewTreeOutlineView;
@synthesize refreshButton;
@synthesize optionsBox;
@synthesize actionsBox;
@synthesize controlViewContainer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // initialize and start the sever
        host = [LDHost sharedInstance];
        host.delegate = self;
        [host start];

    }
    
    return self;
}

-(void)loadView
{
    [super loadView];
    viewTreeOutlineView.delegate = self;
    viewTreeOutlineView.dataSource = self;
    actionsBox.dataSource = self;
    actionsBox.delegate = self;
    
}

- (IBAction)optionsBoxValueChanged:(id)sender {
}

- (IBAction)refreshButtonClicked:(id)sender {
    NSMutableDictionary *packet = [[NSMutableDictionary alloc] init];
    NSString *commandId = [NSString stringWithFormat:@"%d",[[LDCommand broadcastViewTreeCommand] identifier]];
    [packet setObject:commandId forKey:@"cmd"];
    [host broadcastPacket:packet];

}




#pragma mark -
#pragma mark LMHostDelegate
-(void)receivedNewPacket:(NSDictionary*)packet
{
    LDView *treeObject =  [packet objectForKey:@"data"];
    subviewRoot = [treeObject retain];
    if (viewTreeOutlineView!= nil) {
        [viewTreeOutlineView reloadData];
    }
    
}



#pragma mark -
#pragma mark NSOutLineView datasource

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item{
    if (item == nil) {
        item = subviewRoot;
        return subviewRoot;
    }
    LDView *treeNode = (LDView*)item;
    return [treeNode.children objectAtIndex:index];
    
    return nil;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item{
    if (item == nil) {
        return YES;
    }
    LDView *treeNode = (LDView*)item;
    if (treeNode.children != nil) {
        return YES;
    }
    return NO;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item{
    if (item == nil) {
        if (subviewRoot != nil && subviewRoot.children != nil) {
            return [subviewRoot.children count];
        }
        return 1;
    }
    LDView *treeNode = (LDView*)item;
    if (treeNode.children != nil) {
        return [treeNode.children count];
    }
    return 0;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
    if (item == nil) {
        // item = root;
        item = subviewRoot;
    }    
    return  [(LDView*)item name];
}


#pragma mark -
#pragma mark NSOutLineView datasource
- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item
{
    /*select item*/
    LDView *treeNode = (LDView*)item;
    selectedItem = treeNode;
    [actionsBox reloadData];
    
  //  NSView *viewToBeUpdated = [[[myTabView tabViewItems] objectAtIndex:0] view];
    for(NSView *v in [controlViewContainer subviews])
    {
        if ([v isKindOfClass:[ControlView class]]) {
            [v removeFromSuperview];
            [(ControlView*)v cleanup];
        }
        
    }
    [self sendHighlightForViewId:selectedItem.identifier];
    
    return YES;
}




#pragma NSCombobox datasource and delegate
- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox
{
    if (selectedItem != nil) {
        if (selectedItem.messages != nil) {
            return [selectedItem.messages count];
        }
    }
    return 0;
}
- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    id aMessage = [selectedItem.messages objectAtIndex:index];
    if ([aMessage isKindOfClass:[LDMessage class]]) {
        return [(LDMessage*)aMessage displayName];
    }
    else if([aMessage isKindOfClass:[LDProperty class]])
        return [(LDProperty*)aMessage name];
    return nil;
    
}

//TODO: create a formal protocol for Message and Property
- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
    id aMessage =    [selectedItem.messages objectAtIndex: actionsBox.indexOfSelectedItem];
    if ([aMessage isKindOfClass:[LDMessage class]]) {
        [(LDMessage*)aMessage setSelectedView:selectedItem ];
        [(LDMessage*)aMessage populateControls:controlViewContainer];
    }
    else if ([aMessage isKindOfClass:[LDProperty class]])
    {
        [(LDProperty*)aMessage setSelectedView:selectedItem ];
        [(LDProperty*)aMessage populateControls:controlViewContainer];
    }
    
    
}


- (IBAction)showLogButtonClicked:(id)sender {
    
    static NSString *titleForHideLog  = @"hide logs";
    static NSString  *titleForShowLog = @"show logs";
    NSButton *button = (NSButton*)sender;
    NSString *title = button.title;
    if ([title isEqualToString:titleForHideLog]) {
        [button setTitle:titleForShowLog];
        [logWindow setIsVisible:YES];
    }
    else
    {
        [button setTitle:titleForHideLog];
        [logWindow setIsVisible:NO];
    }
}

-(void)sendHighlightForViewId:(NSInteger)viewId
{
    NSMutableDictionary *packet = [[NSMutableDictionary alloc] init];
    NSString *commandId = [NSString stringWithFormat:@"%d",[[LDCommand highlightViewCommand] identifier]];
    [packet setObject:commandId forKey:@"cmd"];
    [packet setObject:[NSString stringWithFormat:@"%d",viewId] forKey:@"id"];
    [host broadcastPacket:packet];
}



@end
