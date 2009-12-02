//
//  STMenuBasicSectionController.h
//  STMenuKit
//
//  Created by Jason Gregori on 11/22/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STMenuFormattedSectionController.h"

@interface STMenuBasicSectionController : STMenuFormattedSectionController
{
    NSArray     *_rows;
    id          _values;
    NSArray     *_keys;
}
// Rows only be set ONCE
@property (nonatomic, copy)   NSArray     *rows;

@end
