//
//  UIViewAdditions.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "UIViewAdditions.h"


@implementation UIView (SimpleTidbits)

- (CGFloat)ST_left
{
	return self.frame.origin.x;
}

- (void)setST_left:(CGFloat)x
{
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat)ST_top
{
	return self.frame.origin.y;
}

- (void)setST_top:(CGFloat)y
{
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat)ST_right
{
	return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)ST_bottom
{
	return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)ST_width
{
	return self.frame.size.width;
}

- (void)setST_width:(CGFloat)width
{
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

- (CGFloat)ST_height
{
	return self.frame.size.height;
}

- (void)setST_height:(CGFloat)height
{
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

- (CGSize)ST_size
{
    return self.frame.size;
}

- (void)setST_size:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
