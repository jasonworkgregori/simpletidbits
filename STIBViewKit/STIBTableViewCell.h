//
//  STIBTableViewCell.h
//  STIBViewKit
//
//  Created by Jason Gregori on 11/1/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 
 See STIBView for how to create a view in IB but use STIBTableViewCell instead
 of STIBView.
 
 You cannot create an instance of your cell in another NIB like you can an
 STIBView.
 
 You cannot set the style or resuseIdentifier, even with
 `initWithStyle:reuseIdentifier:`. This is because we are loading from your
 nib. They will always be what you set them in your NIB. I recommend that you
 set the resuseIdentifier to the class name.
 
 */

@interface STIBTableViewCell : UITableViewCell

// The nibName to load the instance from. Defaults to class name.
// Override if you want to name you nib something besides it's class name.
+ (NSString *)nibName;

@end
