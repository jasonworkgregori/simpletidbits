//
//  NSStringAdditions.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "NSStringAdditions.h"
#import <CommonCrypto/CommonDigest.h>

static NSNumberFormatter *numberFormatter = nil;

@implementation NSString (SimpleTidbits)

- (NSString *)st_stringByURLEncoding
{
    return [((NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                 (CFStringRef)self,
                                                                 NULL,
                                                                 CFSTR("?=&+"),
                                                                 kCFStringEncodingUTF8))
            autorelease];
}

- (NSNumber *)st_numberValue
{
    if (!numberFormatter)
    {
        numberFormatter	= [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    return [numberFormatter numberFromString:self];
}

- (NSString *)st_stringByMD5Encrypting
{
	// thank you to ANDREW PAUL SIMMONS at http://blog.andrewpaulsimmons.com/2008/07/md5-hash-on-iphone.html
	const char *cStr = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, strlen(cStr), result );
	// needs to be lowercased
	return [[NSString stringWithFormat:
			 @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			 result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
			 result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
			 ] lowercaseString];
}

@end
