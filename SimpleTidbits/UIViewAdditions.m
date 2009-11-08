//
//  UIViewAdditions.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "UIViewAdditions.h"


@implementation UIView (SimpleTidbits)

- (CGFloat)st_left
{
	return self.frame.origin.x;
}

- (void)setSt_left:(CGFloat)x
{
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat)st_top
{
	return self.frame.origin.y;
}

- (void)setSt_top:(CGFloat)y
{
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat)st_right
{
	return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)st_bottom
{
	return self.frame.origin.y + self.frame.size.height;
}

// ???: Should this set the top or height?
- (void)setSt_bottom:(CGFloat)bottom
{
    [self setSt_top:(bottom - [self st_height])];
}

- (CGFloat)st_width
{
	return self.frame.size.width;
}

- (void)setSt_width:(CGFloat)width
{
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

- (CGFloat)st_height
{
	return self.frame.size.height;
}

- (void)setSt_height:(CGFloat)height
{
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

- (CGSize)st_size
{
    return self.frame.size;
}

- (void)setSt_size:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
