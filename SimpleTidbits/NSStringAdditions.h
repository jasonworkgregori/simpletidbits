//
//  NSStringAdditions.h
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (SimpleTidbits)

- (NSString *)ST_stringByURLEncoding;

- (NSNumber *)ST_numberValue;

- (NSString *)ST_stringByMD5Encrypting;

@end
