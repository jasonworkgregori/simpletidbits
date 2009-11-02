//
//  STIBTableViewCell.m
//  STIBViewKit
//
//  Created by Jason Gregori on 11/1/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STIBTableViewCell.h"

#import "UIViewAdditions.h"


@implementation STIBTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    // load a new instance from a nib
    id      newSelf     = [[[self class]
                            ST_IBViewForNibNamed:[[self class] nibName]]
                           retain];
    
    // release this instance, because we are going to make a new one
    [self release];
    
    self    = newSelf;
    
    return self;
}


// The nibName to load the instance from. Defaults to class name.
// Override for new views.
+ (NSString *)nibName
{
    return NSStringFromClass(self);
}

@end
