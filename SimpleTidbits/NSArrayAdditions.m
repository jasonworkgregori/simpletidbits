//
//  NSArrayAdditions.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "NSArrayAdditions.h"
#import "NSStringAdditions.h"
#import "NSDictionaryAdditions.h"
#import "NSSetAdditions.h"


@implementation NSArray (SimpleTidbits)

- (NSString *)st_componentsJoinedByString:(NSString *)seperator
						withLastSeperator:(NSString *)lastSeperator
{
    switch ([self count])
    {
        case 0:
            return @"";
        case 1:
            return [[self lastObject] description];
    }
    
    NSMutableString	*string	= [NSMutableString string];
    NSUInteger i, count = [self count];
    for (i = 0; i+2 < count; i++)
    {
        [string appendFormat:@"%@%@", [self objectAtIndex:i], seperator];
    }
    [string appendFormat:@"%@%@%@", [self objectAtIndex:i], lastSeperator, [self objectAtIndex:i+1]];
    
    return string;
}

/*
 Returns a string in the form `key=val1&key=val2...`.
 Asks each value for it's description to make sure it gets a string.
 All values must be NSObjects.
 If an array or set is encountered, st_URLEncodedFormWithKey is called on it
 with the same key and tacked onto the string.
 If a dictionary is encountered, the key is ignored and st_URLEncodedForm is
 called on the dictionary and tacked onto the end.
 */
- (NSString *)st_URLEncodedFormWithKey:(NSObject *)key
{
	NSString	*URLEncodedKey	= [[key description] st_stringByURLEncoding];
	NSMutableString		*form	= [[NSMutableString alloc] init];
	BOOL		firstItem		= YES;
	
	for (id object in self)
	{
		if (firstItem)
		{
			firstItem		= NO;
		}
        else
        {
            [form appendString:@"&"];
        }
		
		if ([object isKindOfClass:[NSArray class]]
			|| [object isKindOfClass:[NSSet class]])
		{
			// If an array or set is encountered, st_URLEncodedFormWithKey is
			// called on it with the same key and tacked onto the string.
			[form appendString:[object st_URLEncodedFormWithKey:key]];
		}
		else if ([object isKindOfClass:[NSDictionary class]])
		{
			// If a dictionary is encountered, the key is ignored and
			// st_URLEncodedForm is called on the dictionary and tacked on.
			[form appendString:[object st_URLEncodedForm]];
		}
		else
		{
			// Just a regular object
			[form appendFormat:@"%@=%@",
			 URLEncodedKey,
			 [[object description] st_stringByURLEncoding]];
		}
	}
	
	return [form autorelease];
}

@end
