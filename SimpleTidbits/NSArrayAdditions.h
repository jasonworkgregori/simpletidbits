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
- (NSString *)ST_componentsJoinedByString:(NSString *)seperator
						withLastSeperator:(NSString *)lastSeperator;

@end
