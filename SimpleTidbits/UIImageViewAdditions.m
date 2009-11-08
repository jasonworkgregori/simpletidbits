//
//  UIImageViewAdditions.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "UIImageViewAdditions.h"


@implementation UIImageView (SimpleTidbits)

+ (id)st_imageViewWithImageNamed:(NSString *)name
{
	UIImage		*image		= [UIImage imageNamed:name];
	if (!image)
	{
		return nil;
	}
	id			imageView	= [[self alloc] initWithImage:image];
	return [imageView autorelease];
}

@end
