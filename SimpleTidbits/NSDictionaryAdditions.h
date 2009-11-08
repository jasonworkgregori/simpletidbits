//
//  NSDictionaryAdditions.h
//  SimpleTidbits
//
//  Created by Jason Gregori on 10/13/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (SimpleTidbits)

/*
 Returns a URL encoded form (name=value&name2=value2...).
 Asks for each key and value's description to make sure it gets strings.
 All keys and values must be NSObjects.
 If an array is encountered, st_URLEncodedFormWithKey is called on the array
 with the key and tacked onto the string.
 If a value is another dictionary, it's key is ignored and st_URLEncodedForm
 is called on it and tacked onto the end.
 */
- (NSString *)st_URLEncodedForm;

@end
