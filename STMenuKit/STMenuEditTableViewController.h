//
//  STMenuEditTableViewController.h
//  STMenuKit
//
//  Created by Jason Gregori on 12/1/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STMenuBasicTableViewController.h"

/*
 
 STMenuEditTableViewController
 ==================================

 An edit table view. Cells are not selectable unless table is in edit mode.
 Right bar button item is edit button.
  
 plist
 -----
 This controller creates a table from a plist using the following format:
 
 [ // table
    {
        // default section controller is the "basic"
        "title"     => section header name
        "rows"      =>
        [
            { // cell
                "title" => title for cell and menu
                "key"   => key for cell, menu, and value
                "defaultValue" => default value

                "cell"  => (STMenuMaker Item) class prefix:"STMenu"
                            suffix:"TableViewCell", secondary prefix:"",
                            suffix:"TableViewCell", default class
                            STMenuTableViewCell.

                "menu"  => (STMenuMaker Item) class prefix:"STMenu",
                            suffix:"ViewController", no default class.
            }
        ]
    }
 ]
 
 */

@interface STMenuEditTableViewController : STMenuBasicTableViewController

@end
