//
//  STIBView.h
//  STIBViewKit
//
//  Created by Jason Gregori on 10/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 
 STIBViews are generated from nibs.
 
 When calling your super init function, make sure you set self to super because
 super returns a different instance.
 
 Initialising with a frame of CGRectZero will leave the default frame size of
 the NIB.
 
 If you use this class you will be able to do the following:
 
 * Create your view in IB.
 * Get an instance of your view programmatically using `alloc` +
   `initWithFrame`.
 * Put an instance of your view in another nib by putting a UIView and giving
   it your custom class. Since it will be replaced by using your original nib,
   not everything you specify in this new nib will be applied. The following
   will be applied:
   * frame
   * alpha
   * tag
   * subviews
 
 
 Creating a view using STIBView and a NIB
 ----------------------------------------
 
 1. Get your view class
    * Use a subclass of `STIBView`. With this you can create instances of your
      view from your class and have access to it's subviews using `IBOutlet`
      properties. Name your nib the same thing as your class (or override
      `+ (NSString *)nibName` in your subclass).
    * Or, use a regular `UIView`. You will only be able to access it's subviews
      by `tag`.
 2. Create your NIB. The owner must be an instance of `STIBViewGenerator`.
    You must connect your custom view as the STIBViewGenerator's view outlet.
    You can copy the example in this project as your starting point.
 3. Creating an Instance
    * For a subclass of STIBView use your subclass' alloc + init/initWithFrame.
    * For a UIView use STIBView's `+ (id)IBViewForNibNamed:`.
 
 */

@interface STIBView : UIView

// The nibName to load the instance from. Defaults to class name.
// Override if you want to name you nib something besides it's class name.
+ (NSString *)nibName;

@end
