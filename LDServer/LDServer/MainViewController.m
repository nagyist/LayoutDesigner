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
#import "TreeUtil.h"
#import "LDCommandMap.h"
#import "LDConstants.h"
#import "NSOutlineView+Additions.h"
#import "LDConstants.h"

@interface MainViewController (Private)
-(void)onItemSelect:(LDView*)item;
-(void)sendHighlightForViewId:(NSInteger)viewId;
-(LDView*)viewForId:(NSInteger)anIdentifier inRoot:(LDView*)aRoot;
@end


@implementation MainViewController
@synthesize viewTreeRoot;
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


-(void)selectViewWithIdentifier:(LDView*)anItem
{
    NSArray *allParents = [TreeUtil allParentsOfNode:anItem inTreeRootedAt:viewTreeRoot];
    for(id parent in allParents)
    {
        [viewTreeOutlineView expandItem:parent];
    }
    [viewTreeOutlineView selectItem:anItem];
    [self onItemSelect:anItem];
}
- (IBAction)optionsBoxValueChanged:(id)sender {
}

- (IBAction)refreshButtonClicked:(id)sender {
    NSMutableDictionary *packet = [[NSMutableDictionary alloc] init];
  //  NSString *commandId = [NSString stringWithFormat:@"%d",[[LDCommand broadcastViewTreeCommand] identifier]];
    
    [packet setObject:ClientCommandSendCurrentViewTree forKey:NetworkPacketKeyCommand];
    [host broadcastPacket:packet];
    
}

-(void)setViewTreeRoot:(LDView *)viewTree
{
    if (viewTree == nil) {
        [viewTreeRoot release];
        viewTreeRoot = nil;
        return;
    }
    LDView *temp = viewTreeRoot;
    viewTreeRoot = [viewTree retain];
    [temp release];
    if (viewTreeOutlineView!= nil) {
        [viewTreeOutlineView reloadData];
    }
}


-(NSArray*)getParents:(LDView*)view fromRoot:(LDView*)root
{
   return [TreeUtil allParentsOfNode:view inTreeRootedAt:root];

}


-(LDView*)viewForId:(NSInteger)anIdentifier inRoot:(LDView*)aRoot
{
    
    return (LDView*)[TreeUtil findNode:anIdentifier inTreeRootedAt:aRoot];
}

#pragma mark -
#pragma mark NSOutLineView datasource

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item{
    if (item == nil) {
        item = viewTreeRoot;
        return viewTreeRoot;
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
        if (viewTreeRoot != nil && viewTreeRoot.children != nil) {
            return [viewTreeRoot.children count];
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
        item = viewTreeRoot;
    }    
    return  [(LDView*)item name];
}


#pragma mark -
#pragma mark NSOutLineView datasource
- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item
{
    /*select item*/
    LDView *treeNode = (LDView*)item;
    [self onItemSelect:treeNode];
    
    return YES;
}

-(void)onItemSelect:(LDView*)item
{
    selectedItem = item;
    [actionsBox reloadData];
    
    for(NSView *v in [controlViewContainer subviews])
    {
        if ([v conformsToProtocol:@protocol(InputView)]) {
            [v removeFromSuperview];
        }
        
    }
    [self sendHighlightForViewId:selectedItem.identifier];
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
        [(LDProperty*)aMessage setViewTreeRoot:viewTreeRoot ];
        [(LDProperty*)aMessage populateControls:controlViewContainer];
    }
    
    
}

-(void)sendHighlightForViewId:(NSInteger)viewId
{
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:[NSString stringWithFormat:@"%d",viewId] forKey:NetworkPacketDataKeyViewId];
    [data setObject:[NSString stringWithFormat:@"%d",viewTreeRoot.identifier] forKey:NetworkPacketDataKeyRootViewId];
    [host sendCommand:ClientCommandHighlightView withData:data];
}



@end
