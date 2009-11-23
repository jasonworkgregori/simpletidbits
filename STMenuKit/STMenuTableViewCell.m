//
//  STMenuTableViewCell.m
//  STMenuKit
//
//  Created by Jason Gregori on 11/21/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STMenuTableViewCell.h"


@implementation STMenuTableViewCell
@synthesize key = _key, title = _title, value = _value;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // Initialization code
    }
    return self;
}


- (void)dealloc
{
    [_key release];
    [_title release];
    [_value release];
    
    [super dealloc];
}

+ (CGFloat)heightWithTitle:(NSString *)title value:(id)value
{
    return 44;
}

- (void)st_prepareForReuse
{
    
}

- (void)cellWasSelected
{
    
}

#pragma mark -
#pragma mark UITableViewCell



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
