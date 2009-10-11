//
//  UIAlertViewAdditions.h
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIAlertView (SimpleTidbits)

+ (id)ST_showAlertViewWithTitle:(NSString *)title
						message:(NSString *)message;

@end
