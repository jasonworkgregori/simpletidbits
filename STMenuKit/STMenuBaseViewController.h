//
//  STMenuBaseViewController.h
//  STMenuKit
//
//  Created by Jason Gregori on 12/14/09.
//  Copyright 2009 Slingshot Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STMenuProtocol.h"
#import "STLoadingView.h"

@interface STMenuBaseViewController : UIViewController
<STMenuProtocol>
{
@private
    // used to store plist name
    NSString        *_plistName;
    // used to store plist data
    id              _schema;
    id              _value;
    BOOL            _loading;
    NSString		*_loadingMessage;
    STLoadingView	*_loadingView;
    
    NSString        *_key;
    BOOL            _parentMenuShouldSave;
    
    UIViewController <STMenuProtocol>   *_subMenu;
    NSMutableDictionary     *_cachedMenus;
}

#pragma mark For Subclass or Private Use Only

// use this to know when schema was changed
// copied if possible
@property (nonatomic, copy, readonly)   NSString    *st_plistName;
@property (nonatomic, copy)   id        st_schema;
@property (nonatomic, readonly, retain) UIViewController <STMenuProtocol>
  *st_subMenu;

// default menu class, defaults to [self class]
- (Class)st_defaultMenuClass;

// Use this to push a subMenu. It will set self.st_subMenu to this. It will set
// parentMenuShouldSave to NO on the submenu.
- (void)st_pushMenu:(UIViewController <STMenuProtocol> *)subMenu;

// Override this to save values returned by sub menus. This will only be called
// if you pushed the sub menu using st_pushMenu and the menu has set
// parentMenuShouldSave to YES. Default does nothing.
- (void)st_saveValue:(id)value forSubMenuKey:(NSString *)key;

// Gets an instance of a menu, either by creating one or by using a cached one.
// Data could be either a the class name (NSString) or a dictionary.
// For the class, we try to find a class named
// "STMenu"+className+"ViewController". If that doesn't work, we try className.
// If data is a dictionary, it must have a key named "class" that follows the
// above constaints.
// Uses "key" to determine if we are using the menu for a new use.
// If key is different, resets all values and calls 'st_prepareForReuse'.
// Use nil key to reset no matter what.
// Uses st_defaultMenuClass for the default menu class.
// Either returns a view controller or throws an exception.
- (UIViewController <STMenuProtocol> *)st_getMenuFromData:(id)data
                                                   forKey:(NSString *)key;

@end