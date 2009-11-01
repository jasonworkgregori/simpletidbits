//
//  NSDictionaryAdditions.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 10/13/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "NSDictionaryAdditions.h"
#import "NSStringAdditions.h"
#import "NSArrayAdditions.h"
#import "NSSetAdditions.h"


@implementation NSDictionary (SimpleTidbits)

/*
 Returns a URL encoded form (name=value&name2=value2...).
 Asks for each key and value's description to make sure it gets strings.
 All keys and values must be NSObjects.
 If an array is encountered, ST_URLEncodedFormWithKey is called on the array
 with the key and tacked onto the string.
 If a value is another dictionary, it's key is ignored and ST_URLEncodedForm
 is called on it and tacked onto the end.
 */
- (NSString *)ST_URLEncodedForm
{
	NSMutableString		*form	= [[NSMutableString alloc] init];
	BOOL		firstItem		= YES;
	
	for (id key in self)
	{
		id	object	= [self objectForKey:key];
		
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
			 [[key description] ST_stringByURLEncoding],
			 [[object description] ST_stringByURLEncoding]];
		}
	}
	
	return [form autorelease];
}

@end
