//
//  STMenuSectionController.h
//  STMenuKit
//
//  Created by Jason Gregori on 11/21/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STMenuFormattedTableViewController.h"
#import "STMenuTableViewCell.h"

/*
 A section controller's job is to control all the cell's in it's section.
 
 It must also push subMenus onto it's menu and deal with the returned subMenu.
 
 It may use it's menu property to observe values, push menus, or whatever.
 
 It is the section controller's job to observe value changes (using KVO) to
 update it's cells.
 */

@interface STMenuFormattedSectionController : NSObject
{
    STMenuFormattedTableViewController  *_menu;
    NSUInteger      _section;
    NSDictionary    *_sectionData;
}
@property (nonatomic, assign)   STMenuFormattedTableViewController  *menu;
@property (nonatomic, assign)   NSUInteger      section;
@property (nonatomic, retain)   NSDictionary    *sectionData;

// cells
- (STMenuTableViewCell *)tableView:(UITableView *)tableView
                        cellForRow:(NSUInteger)row;
- (NSInteger)numberOfRows;
- (CGFloat)heightForRow:(NSUInteger)row;

// editing
- (BOOL)shouldIndentWhileEditingRow:(NSUInteger)row;
- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                    forRow:(NSUInteger)row;
- (BOOL)canEditRow:(NSUInteger)row;
- (UITableViewCellEditingStyle)editingStyleForRow:(NSUInteger)row;

// submenus
- (void)saveValue:(id)value forSubMenuKey:(NSString *)key;

@end
