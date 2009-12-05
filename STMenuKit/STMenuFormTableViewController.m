//
//  STMenuFormTableViewController.m
//  STMenuKit
//
//  Created by Jason Gregori on 12/3/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STMenuFormTableViewController.h"
#import "STMenuFormTableViewCell.h"


@implementation STMenuFormTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStyleGrouped])
    {
        self.editing    = YES;
    }
    return self;
}

#pragma mark STMenuBaseTableViewController

- (Class)st_defaultCellClass
{
    return [STMenuFormTableViewCell class];
}

- (NSString *)st_customCellPrefix
{
    return @"STMenuForm";
}

#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.allowsSelectionDuringEditing = YES;
}

@end
