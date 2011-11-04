//
//  NSOutlineView+Additions.m
//  LDServer
//
//  Created by Ved Surtani on 03/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSOutlineView+Additions.h"

@implementation NSOutlineView (Additions)


- (void)expandParentsOfItem:(id)item {
    while (item != nil) {
        id parent = [self parentForItem: item];
        if (parent == nil) {
            return;
        }
        if (![self isExpandable: parent])
            break;
        if ([self isItemExpanded: parent])
            [self expandItem: parent];
        //item = parent;
        //now expand parent of this parent
        [self expandParentsOfItem:parent];
    }
}

-(void)expandAllSubItems:(id)item
{
    
}

- (void)selectItem:(id)item {
    NSInteger itemIndex = [self rowForItem:item];
    if (itemIndex < 0) {
        [self expandParentsOfItem: item];
        itemIndex = [self rowForItem:item];
        if (itemIndex < 0)
            return;
    }
    
    [self selectRowIndexes: [NSIndexSet indexSetWithIndex: itemIndex] byExtendingSelection: NO];
}

@end
