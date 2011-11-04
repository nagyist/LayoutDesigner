//
//  NSOutlineView+Additions.h
//  LDServer
//
//  Created by Ved Surtani on 03/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSOutlineView (Additions)
- (void)expandParentsOfItem:(id)item;
-(void)expandAllSubItems:(id)item;
- (void)selectItem:(id)item;

@end
