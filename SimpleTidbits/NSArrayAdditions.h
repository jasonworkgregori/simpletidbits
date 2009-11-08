//
//  NSArrayAdditions.h
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (SimpleTidbits)

// Similar to componentsJoinedByString except allow for a different last seperator
- (NSString *)st_componentsJoinedByString:(NSString *)seperator
						withLastSeperator:(NSString *)lastSeperator;

/*
 Returns a string in the form `key=val1&key=val2...`.
 Asks each value for it's description to make sure it gets a string.
 All values must be NSObjects.
 If an array or set is encountered, st_URLEncodedFormWithKey is called on it
 with the same key and tacked onto the string.
 If a dictionary is encountered, the key is ignored and st_URLEncodedForm is
 called on the dictionary and tacked onto the end.
 */
- (NSString *)st_URLEncodedFormWithKey:(NSObject *)key;

@end
