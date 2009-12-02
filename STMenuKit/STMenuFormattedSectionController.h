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
 update it's cells and it's submenus.
 
 Use menu to create cells.
 */

@interface STMenuFormattedSectionController : NSObject
{
    STMenuFormattedTableViewController  *_menu;
    NSUInteger      _section;
    NSString        *_title;
}
@property (nonatomic, assign)   STMenuFormattedTableViewController  *menu;
@property (nonatomic, assign)   NSUInteger      section;
@property (nonatomic, copy)     NSString        *title;

// Menu
// Called when menu's value property has changed.
- (void)menuValueDidChange:(id)newValue;
// Menu calls this when subMenu returns
- (void)saveValue:(id)value forSubMenuKey:(NSString *)key;

// Cells
- (NSInteger)numberOfRows;
- (void)didSelectRow:(NSUInteger)row;

// The next two methods will use the subclass methods to figure these out.
// Override the subclass methods OR these OR both.
// height uses class, title, and value
- (CGFloat)heightForRow:(NSUInteger)row;
// cell uses title, value, key, and row data
- (STMenuTableViewCell *)cellForRow:(NSUInteger)row;

// Cell editing
- (BOOL)shouldIndentWhileEditingRow:(NSUInteger)row;
- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                    forRow:(NSUInteger)row;
- (BOOL)canEditRow:(NSUInteger)row;
- (UITableViewCellEditingStyle)editingStyleForRow:(NSUInteger)row;

// Subclass these! OR height and cellForRow methods OR both
// default: will get class from row data
- (Class)classForRow:(NSUInteger)row;
- (NSString *)titleForRow:(NSUInteger)row;
- (id)valueForRow:(NSUInteger)row;
- (id)cellDataForRow:(NSUInteger)row;
- (NSString *)keyForRow:(NSUInteger)row;

@end
