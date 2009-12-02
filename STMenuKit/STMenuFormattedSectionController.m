//
//  STMenuSectionController.m
//  STMenuKit
//
//  Created by Jason Gregori on 11/21/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STMenuFormattedSectionController.h"


@implementation STMenuFormattedSectionController
@synthesize menu = _menu, section = _section, title = _title;

- (void)dealloc
{
    [_title release];
    
    [super dealloc];
}

- (void)menuValueDidChange:(id)newValue
{
    
}

// submenus
- (void)saveValue:(id)value forSubMenuKey:(NSString *)key
{
    
}

// cells
- (NSInteger)numberOfRows
{
    return 0;
}

- (CGFloat)heightForRow:(NSUInteger)row
{
    return [[self classForRow:row]
            heightWithTitle:[self titleForRow:row]
            value:[self valueForRow:row]];
}

- (STMenuTableViewCell *)cellForRow:(NSUInteger)row
{
    STMenuTableViewCell     *cell
      = [self.menu st_cellWithCellData:[self cellDataForRow:row]
                                   key:[self keyForRow:row]];
    [cell setTitle:[self titleForRow:row]];
    [cell setValue:[self valueForRow:row]];
    return cell;
}

- (void)didSelectRow:(NSUInteger)row
{
    NSDictionary    *menu       = [self menuDataForRow:row];
    if (menu)
    {
        // if there is a menu, push it!
        NSString    *key        = [self keyForRow:row];

        // get menu
        UIViewController <STMenuProtocol>   *subMenu
          = [self.menu st_getMenuFromData:menu forKey:key];
        // set value
        subMenu.value   = [self valueForRow:row];
        // set title
        subMenu.title   = [self titleForRow:row];
        
        // push it
        [self.menu st_pushMenu:subMenu forSection:self.section];
    }
}

// cell editing
- (BOOL)shouldIndentWhileEditingRow:(NSUInteger)row
{
    return YES;
}

- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                    forRow:(NSUInteger)row
{
    
}

- (BOOL)canEditRow:(NSUInteger)row
{
    return YES;
}

- (UITableViewCellEditingStyle)editingStyleForRow:(NSUInteger)row
{
    return UITableViewCellEditingStyleDelete;
}

// for subclasses
- (Class)classForRow:(NSUInteger)row
{
    return [STMenuTableViewCell
            classForCellData:[self cellDataForRow:row]
            defaultClass:[self.menu st_defaultCellClass]];
}

- (NSString *)titleForRow:(NSUInteger)row
{
    return nil;
}

- (id)valueForRow:(NSUInteger)row
{
    return nil;
}

- (id)cellDataForRow:(NSUInteger)row
{
    return nil;
}

- (NSString *)keyForRow:(NSUInteger)row
{
    return nil;
}

- (id)menuDataForRow:(NSUInteger)row
{
    return nil;
}

@end
