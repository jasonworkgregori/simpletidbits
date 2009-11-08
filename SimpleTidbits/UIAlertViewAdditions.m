//
//  UIAlertViewAdditions.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "UIAlertViewAdditions.h"


@implementation UIAlertView (SimpleTidbits)

+ (id)st_showAlertViewWithTitle:(NSString *)title
						message:(NSString *)message
{
	id		alert		= [[[self class] alloc] initWithTitle:title
											 message:message
											delegate:nil
								   cancelButtonTitle:@"OK"
								   otherButtonTitles:nil];
    [alert show];
	return [alert autorelease];
}

@end
