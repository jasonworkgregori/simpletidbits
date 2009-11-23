//
//  STMenuFormTableViewController.h
//  STMenuKit
//
//  Created by Jason Gregori on 11/22/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 
 STMenuFormattedTableViewController
 ==================================
 
 plist
 -----
 This controller creates a table from a plist using the following format:
 
    [ // table
        {
             // section (special type), class prefix:"STMenu",
             // suffix:"SectionController", default class
             // STMenuBasicSectionController. Cannot be nil.
             // The following is using default class
             "title"     => section header name
             "rows"      =>
             [
                 { // cell
                     "title" => title for cell and menu
                     "key"   => key for cell, menu, and value
                     "value" => default value
                     
                     "cell"  => (special type) class prefix:"STMenu"
                                suffix:"TableViewCell", default class
                                STMenuTableViewCell.
                     
                     "menu"  => (special type) class prefix:"STMenu",
                                suffix:"ViewController", no default class.
                 }
             ]
         }
     ]
 
 Special Types
 -------------
 
 A special type has the following attributes:
 *  Can be a string (class name), a dictionary, or nil (use default).
 *  If a dictionary, may have a key "class" that is class name, otherwise, we
    use the default class.
 *  For the class name we try a certain prefix and suffix first then just
    the class name if that doesn't work, then we use the default class if that
    doesn't work.
 *  Any other items in the dictionary are treated as property keys/values for
    the instance we create, and are passed to the instance.
 *  Usually we will have a "plist" key that customizes the instance further.
 *  We use STMenuMaker to create these instances.
 
 
 value
 -----
 Value must be a KVC object and respond to every key in the menuMap. Value will
 be observed using KVO. You may change something in the value using KVC and the
 table and sub menus will update automatically. Usually you would use a mutable
 dictionary.
 
 */

@interface STMenuFormTableViewController : UITableViewController {

}

@end
