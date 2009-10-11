//
//  NSDateAdditions.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "NSDateAdditions.h"

static NSDateFormatter *shortDateFormatter = nil;
static NSDateFormatter *longDateFormatter = nil;

@implementation NSDate (SimpleTidbits)

- (NSString *)ST_shortStringValue
{
	if (!shortDateFormatter)
	{
		shortDateFormatter	= [[NSDateFormatter alloc] init];
		[shortDateFormatter setDateStyle:NSDateFormatterShortStyle];
		[shortDateFormatter setTimeStyle:NSDateFormatterNoStyle];
	}
	return [shortDateFormatter stringFromDate:self];
}

- (NSString *)ST_longStringValue
{
	if (!longDateFormatter)
	{
		longDateFormatter	= [[NSDateFormatter alloc] init];
		[longDateFormatter setDateStyle:NSDateFormatterLongStyle];
		[longDateFormatter setTimeStyle:NSDateFormatterNoStyle];
	}
	return [longDateFormatter stringFromDate:self];
}


@end
