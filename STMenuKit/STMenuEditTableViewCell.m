//
//  STMenuEditTableViewCell.m
//  STMenuKit
//
//  Created by Jason Gregori on 12/1/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STMenuEditTableViewCell.h"


@implementation STMenuEditTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleValue2
                    reuseIdentifier:reuseIdentifier])
    {
        self.editingAccessoryType
          = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}



@end
