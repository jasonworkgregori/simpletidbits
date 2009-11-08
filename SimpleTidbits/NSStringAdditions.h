//
//  NSStringAdditions.h
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (SimpleTidbits)

- (NSString *)st_stringByURLEncoding;

- (NSNumber *)st_numberValue;

- (NSString *)st_stringByMD5Encrypting;

@end
