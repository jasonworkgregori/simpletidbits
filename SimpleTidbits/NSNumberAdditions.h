//
//  NSNumberAdditions.h
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSNumber (SimpleTidbits)

// String formatted to localized format (eg 1000 => @"1,000" in US english)
// Uses NSNumberFormattor with NSNumberFormatterDecimalStyle
- (NSString *)st_formattedStringValue;

// This way we can get an NSNumber from a string OR number without having to check
- (NSNumber *)st_numberValue;

@end
