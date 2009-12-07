//
//  STMenuBasicSectionController.h
//  STMenuKit
//
//  Created by Jason Gregori on 11/22/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STMenuFormattedSectionController.h"

/*
 
 STMenuBasicSectionController
 ============================
 
 plist
 -----
 This controller creates a section from a plist using the following format:
 

 {
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
 
 */

@interface STMenuBasicSectionController : STMenuFormattedSectionController
{
    NSArray     *_rows;
    id          _values;
    NSArray     *_keys;
}
// Rows only be set ONCE
@property (nonatomic, copy)   NSArray     *rows;

@end
