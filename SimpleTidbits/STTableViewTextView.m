//
//  STTableViewTextView.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 12/13/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STTableViewTextView.h"


@implementation STTableViewTextView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame])
    {
        // Initialization code
        UILabel     *label      = [[UILabel alloc] init];
        label.backgroundColor   = [UIColor clearColor];
        label.textAlignment     = UITextAlignmentCenter;
        label.numberOfLines     = 0;
        label.font              = [UIFont systemFontOfSize:15];
        label.adjustsFontSizeToFitWidth = NO;
        label.textColor         = [UIColor colorWithRed:0.304
                                                  green:0.358
                                                   blue:0.435
                                                  alpha:1.000];
        label.shadowColor       = [UIColor whiteColor];
        label.shadowOffset      = CGSizeMake(0, 1);
        self.contentView        = label;
        [label release];
    }
    return self;
}

- (NSString *)text
{
    return self.label.text;
}

- (void)setText:(NSString *)text
{
    self.label.text = text;
    [self sizeToFit];
}

- (UILabel *)label
{
    return (id)self.contentView;
}

#pragma mark UIView

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize  superSize  = [super sizeThatFits:CGSizeMake(320.0, CGFLOAT_MAX)];
    if (superSize.width < 320)
    {
        // make sure size is the width of a tableview
        superSize.width  = 320;
    }
    return superSize;
}

@end
