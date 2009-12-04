//
//  STMenuFormTableViewController.h
//  STMenuKit
//
//  Created by Jason Gregori on 12/3/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STMenuBasicTableViewController.h"

/*
 
 STMenuFormTableViewController
 ==================================
 
 A form table view. This is designed to be like the settings app.
 Cells should allow you to directly edit the value.
 Cells should may load a subMenu instead to edit the item.
 Menu is always in edit mode.
 
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

@interface STMenuFormTableViewController : STMenuBasicTableViewController

@end
