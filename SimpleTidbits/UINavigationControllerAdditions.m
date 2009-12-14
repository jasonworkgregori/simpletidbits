//
//  UINavigationControllerAdditions.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 12/13/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "UINavigationControllerAdditions.h"


@implementation UINavigationController (SimpleTidbits)

+ (id)navigationControllerWithRootViewController:(UIViewController *)root
{
    return [[[self alloc] initWithRootViewController:root] autorelease];
}

@end
