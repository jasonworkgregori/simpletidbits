//
//  UIViewAdditions.h
//  STIBViewKit
//
//  Created by Jason Gregori on 11/1/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 
 See STIBView for how to set up NIB.
 
 */

@interface UIView (STIBViewKit)

// Load a non STIBView view from a nib that is in the form the above
// instructions (with the generator and all). To load an STIBView subclass you
// must use `+ instance` or `alloc` + `init`/`initWithFrame`.
+ (id)ST_IBViewForNibNamed:(NSString *)nibName;

@end
