//
//  NSNumberAdditions.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "NSNumberAdditions.h"

static NSNumberFormatter *numberFormatter = nil;

@implementation NSNumber (SimpleTidbits)

- (NSString *)ST_formattedStringValue
{
    if (!numberFormatter)
    {
        numberFormatter	= [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    return [numberFormatter stringFromNumber:self];
}

- (NSNumber *)ST_numberValue
{
	return self;
}

@end
