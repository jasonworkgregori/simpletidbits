//
//  STMenuTextFieldTableViewCell.h
//  STMenuKit
//
//  Created by Jason Gregori on 12/4/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STMenuTableViewCell.h"

/*
 
 
 
 There is a problem that if this cell is selected and then another cell is
 selected and pushes a submenu, the cell will be deselected and the keyboard
 will hide, BUT on return the tableView will have its contentInsets set like
 the keyboard is still there. To fix this we will have to take over keyboard
 animations. We might need to use a custom VC instead of UITableViewController.
 */

@interface STMenuTextFieldTableViewCell : STMenuTableViewCell
<UITextFieldDelegate>
{
    UITextField     *_textField;
    NSIndexPath     *_nextCellIndexPath;
    BOOL            _doneOnReturn;
}
@property (nonatomic, retain, readonly) UITextField *textField;

// TextInputTraits, these all return nil, they are setonly

// Options: none, words, sentences, allCharacters
// Default: none
@property (nonatomic, copy) NSString    *autocapitalizationType;
// Options: default, no, yes
// Default: default
@property (nonatomic, copy) NSString    *autocorrectionType;
// BOOL
// Default: NO
@property (nonatomic, retain)   NSNumber    *enablesReturnKeyAutomatically;
// Options: default, asciiCapable, numbersAndPunctuation, url, numberPad,
//          phonePad, emailAddress
// Default: default
@property (nonatomic, copy) NSString    *keyboardType;
// BOOL
// Default: NO
@property (nonatomic, retain)   NSNumber    *secureTextEntry;
// Options: default, go, google, join, next, route, search, send, yahoo, done,
//          emergencyCall
// Default: default
@property (nonatomic, copy) NSString    *returnKeyType;

// Other traits

// NSString of the form "section,row" (eg "0,1")
// When this is set, tapping the return key selects this row
// Making this non nil also sets returnKeyType to next.
@property (nonatomic, copy) NSString    *nextCellIndexPath;
// BOOL
// When this value is YES, we call menu's done method when the return key is
// tapped. Default: NO
@property (nonatomic, retain)   NSNumber    *doneOnReturn;

@end
