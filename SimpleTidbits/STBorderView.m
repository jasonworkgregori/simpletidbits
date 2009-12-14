//
//  STBorderView.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 12/9/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STBorderView.h"


@implementation STBorderView
@synthesize contentView = _contentView, margins = _margins;


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // Initialization code
        self.margins    = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}

- (void)dealloc
{
    [_contentView release];
    
    [super dealloc];
}

- (void)setMargins:(UIEdgeInsets)margins
{
    _margins    = margins;
    
    [self setNeedsLayout];
}

- (void)setContentView:(UIView *)contentView
{
    if (_contentView != contentView)
    {
        [_contentView release];
        _contentView    = [contentView retain];
        _contentView.autoresizingMask   = (UIViewAutoresizingFlexibleWidth
                                           | UIViewAutoresizingFlexibleHeight);
        [self addSubview:_contentView];
    }
    
    [self setNeedsLayout];
}

#pragma mark UIView

- (CGSize)sizeThatFits:(CGSize)size
{
    // We size our self based off our contentView
    CGSize      newContentSize
      = [self.contentView
         sizeThatFits:CGSizeMake(size.width
                                 - self.margins.left
                                 - self.margins.right,
                                 size.height
                                 - self.margins.top
                                 - self.margins.bottom)];
    return CGSizeMake(newContentSize.width
                      + self.margins.left
                      + self.margins.right,
                      newContentSize.height
                      + self.margins.top
                      + self.margins.bottom);
}

- (void)layoutSubviews
{
    self.contentView.frame  = UIEdgeInsetsInsetRect(self.bounds,
                                                    self.margins);
}

@end











