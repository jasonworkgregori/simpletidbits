//
//  STMenuFormTableViewController.m
//  STMenuKit
//
//  Created by Jason Gregori on 11/22/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STMenuBasicTableViewController.h"
#import "STMenuBasicSectionController.h"


@implementation STMenuBasicTableViewController

- (Class)st_defaultSectionClass
{
    return [STMenuBasicSectionController class];
}

@end

