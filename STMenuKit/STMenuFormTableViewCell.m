//
//  STMenuFormTableViewCell.m
//  STMenuKit
//
//  Created by Jason Gregori on 12/3/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STMenuFormTableViewCell.h"


@implementation STMenuFormTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleValue1
                    reuseIdentifier:reuseIdentifier])
    {
        self.editingAccessoryType
          = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

@end
