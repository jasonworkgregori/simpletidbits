//
//  STMenuEditTableViewController.m
//  STMenuKit
//
//  Created by Jason Gregori on 12/1/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STMenuEditTableViewController.h"
#import "STMenuEditTableViewCell.h"


@implementation STMenuEditTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStyleGrouped])
    {
        self.navigationItem.rightBarButtonItem  = self.editButtonItem;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.allowsSelection  = NO;
    self.tableView.allowsSelectionDuringEditing = YES;
}

- (Class)st_defaultCellClass
{
    return [STMenuEditTableViewCell class];
}

@end
