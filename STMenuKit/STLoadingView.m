//
//  STLoadingView.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 12/14/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STLoadingView.h"
#import <QuartzCore/QuartzCore.h>

#define kSTLoadingViewWidthWithText     150
#define kSTLoadingViewWidthWithoutText  100
#define kSTLoadingViewTopMargin     20
#define kSTLoadingViewMidMargin     20
#define kSTLoadingViewSideMargin    20
#define kSTLoadingViewBottomMargin  20

@interface STLoadingView ()

@property (nonatomic, readonly) UIActivityIndicatorView *st_aiv;

@end

@implementation STLoadingView
@synthesize label = _label, st_aiv = _aiv;


- (id)initWithFrame:(CGRect)frame
{
    if (CGRectEqualToRect(frame, CGRectZero))
    {
        frame   = CGRectMake(0, 0,
                             kSTLoadingViewWidthWithoutText,
                             kSTLoadingViewWidthWithoutText);
    }
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor    = [UIColor colorWithWhite:0 alpha:0.8];
        self.layer.cornerRadius = 10;
        
        _aiv    = [[UIActivityIndicatorView alloc]
                   initWithActivityIndicatorStyle:
                   UIActivityIndicatorViewStyleWhiteLarge];
        _aiv.autoresizingMask    = (UIViewAutoresizingFlexibleLeftMargin
                                    | UIViewAutoresizingFlexibleRightMargin
                                    | UIViewAutoresizingFlexibleTopMargin);
        _aiv.center     = CGPointMake(floor(self.frame.size.width/2.0),
                                      floor(self.frame.size.height/2.0));
        [_aiv startAnimating];
        [self addSubview:self.st_aiv];
        _label      = [[UILabel alloc]
                       initWithFrame:CGRectMake(kSTLoadingViewSideMargin,
                                                kSTLoadingViewTopMargin,
                                                frame.size.width
                                                - 2* kSTLoadingViewSideMargin,
                                                frame.size.height
                                                - kSTLoadingViewTopMargin
                                                - kSTLoadingViewMidMargin
                                                - _aiv.frame.size.height
                                                - kSTLoadingViewBottomMargin)];
        self.label.autoresizingMask = (UIViewAutoresizingFlexibleHeight
                                       | UIViewAutoresizingFlexibleWidth);
        self.label.textAlignment    = UITextAlignmentCenter;
        self.label.textColor        = [UIColor whiteColor];
        self.label.backgroundColor  = [UIColor clearColor];
        [self addSubview:self.label];
    }
    return self;
}


- (void)dealloc
{
    [_aiv release];
    [_label release];
    
    [super dealloc];
}


- (void)setText:(NSString *)text
{
    self.label.text     = text;
    if (text)
    {
        // with text the loading view is larger and the aiv is at the bottom
        self.bounds     = CGRectMake(0, 0,
                                     kSTLoadingViewWidthWithText,
                                     kSTLoadingViewWidthWithText);
        self.st_aiv.center
          = CGPointMake(floor(self.frame.size.width/2.0),
                        self.frame.size.height
                        - kSTLoadingViewBottomMargin
                        - floor(self.st_aiv.frame.size.height/2.0));        
    }
    else
    {
        // without text, the view is smaller and the aiv is centered
        self.bounds     = CGRectMake(0, 0,
                                     kSTLoadingViewWidthWithoutText,
                                     kSTLoadingViewWidthWithoutText);
        self.st_aiv.center
          = CGPointMake(floor(self.frame.size.width/2.0),
                        floor(self.frame.size.height/2.0));
    }

    [self sizeToFit];
}

- (NSString *)text
{
    return self.label.text;
}

#pragma mark UIView

- (CGSize)sizeThatFits:(CGSize)size
{
    if (self.text)
    {
        CGSize      sizeOfText      = [self.label.text
                                       sizeWithFont:self.label.font
                                       constrainedToSize:
                                       CGSizeMake(kSTLoadingViewWidthWithText
                                                  - 2 * kSTLoadingViewSideMargin,
                                                  CGFLOAT_MAX)];
        return CGSizeMake(kSTLoadingViewWidthWithText,
                          sizeOfText.height
                          + kSTLoadingViewTopMargin
                          + kSTLoadingViewMidMargin
                          + self.st_aiv.frame.size.height
                          + kSTLoadingViewBottomMargin);
    }
    return CGSizeMake(kSTLoadingViewWidthWithoutText,
                      kSTLoadingViewWidthWithoutText);
}

@end
