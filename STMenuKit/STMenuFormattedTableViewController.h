//
//  STMenuFormattedTableViewController.h
//  STMenuKit
//
//  Created by Jason Gregori on 11/12/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "STMenuBaseTableViewController.h"


/*
 
 STMenuFormattedTableViewController
 ==================================
 
 plist
 -----
 This controller creates a table from a plist using the following format:
 
    [ // table
        {
            section: (STMenuMaker Item), class prefix:"STMenu",
            suffix:"SectionController", no default class. Sections cannot be
            nil. See section controllers for what to put in here.
        }
    ]
 
 value
 -----
 Value must be a KVC object and respond to every key in the menuMap. Value will
 be observed using KVO. You may change something in the value using KVC and the
 table and sub menus will update automatically. Usually you would use a mutable
 dictionary.
 
 */

@interface STMenuFormattedTableViewController : STMenuBaseTableViewController
{
  @private
    NSMutableArray      *_sections;
    NSUInteger          _subMenuSection;
}

#pragma mark Subclass or Private Use Only

// Section Controller's use this to push a subMenus.
- (void)st_pushMenu:(UIViewController <STMenuProtocol> *)subMenu
         forSection:(NSUInteger)section;

@end
