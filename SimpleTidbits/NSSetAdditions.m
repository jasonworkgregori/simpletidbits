//
//  NSSetAdditions.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 10/13/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "NSSetAdditions.h"
#import "NSStringAdditions.h"
#import "NSDictionaryAdditions.h"
#import "NSArrayAdditions.h"


@implementation NSSet (SimpleTidbits)

/*
 Returns a string in the form `key=val1&key=val2...`.
 Asks each value for it's description to make sure it gets a string.
 All values must be NSObjects.
 If an array or set is encountered, ST_URLEncodedFormWithKey is called on it
 with the same key and tacked onto the string.
 If a dictionary is encountered, the key is ignored and ST_URLEncodedForm is
 called on the dictionary and tacked onto the end.
 */
- (NSString *)ST_URLEncodedFormWithKey:(NSObject *)key
{
	NSString	*URLEncodedKey	= [[key description] ST_stringByURLEncoding];
	NSMutableString		*form	= [[NSMutableString alloc] init];
	BOOL		firstItem		= YES;
	
	for (id object in self)
	{
		if (!firstItem)
		{
			[form appendString:@"&"];
			firstItem		= NO;
		}
		
		if ([object isKindOfClass:[NSArray class]]
			|| [object isKindOfClass:[NSSet class]])
		{
			// If an array or set is encountered, ST_URLEncodedFormWithKey is
			// called on it with the same key and tacked onto the string.
			[form appendString:[object ST_URLEncodedFormWithKey:key]];
		}
		else if ([object isKindOfClass:[NSDictionary class]])
		{
			// If a dictionary is encountered, the key is ignored and
			// ST_URLEncodedForm is called on the dictionary and tacked on.
			[form appendString:[object ST_URLEncodedForm]];
		}
		else
		{
			// Just a regular object
			[form appendFormat:@"%@=%@",
			 URLEncodedKey,
			 [[object description] ST_stringByURLEncoding]];
		}
	}
	
	return [form autorelease];
}

@end
