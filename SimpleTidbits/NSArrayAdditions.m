//
//  NSArrayAdditions.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "NSArrayAdditions.h"


@implementation NSArray (SimpleTidbits)

- (NSString *)ST_componentsJoinedByString:(NSString *)seperator
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

@end
