//
//  UIActivityIndicatorAdditions.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "UIActivityIndicatorViewAdditions.h"


@implementation UIActivityIndicatorView (SimpleTidbits)

+ (id)st_activityIndicatorWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style
{
    id		aiv		= [[self alloc] initWithActivityIndicatorStyle:style];
    [aiv startAnimating];
    return [aiv autorelease];
}

@end
