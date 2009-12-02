//
//  STMenuProtocol.h
//  STMenuKit
//
//  Created by Jason Gregori on 11/8/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#include <Foundation/Foundation.h>

@protocol STMenuProtocol

@required

// plist can either be a string, in which case it will be used as a file name
// for loading a plist from disk, or a plist object.
// Must return what is put in so save plist strings separately from plist
// object.
// Should be copied if possible.
@property (nonatomic, copy)     id          plist;
@property (nonatomic, retain)   id          value;

@property (nonatomic, copy)     NSString    *key;
@property (nonatomic, assign)   BOOL        parentMenuShouldSave;

- (void)setPlist:(id)plist andValue:(id)value;

// create an instance of a menu
+ (id)menu;

#pragma mark For Subclass Use Only

// This is called when a menu is reused. Reset all editable properties
- (void)st_prepareForReuse;

@end
