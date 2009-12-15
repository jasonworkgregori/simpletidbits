//
//  STLoadingView.h
//  SimpleTidbits
//
//  Created by Jason Gregori on 12/14/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface STLoadingView : UIView
{
    UIActivityIndicatorView *_aiv;
    UILabel         *_label;
}
// Use text property to set text not the label, otherwise it won't be resized
@property (nonatomic, copy)     NSString        *text;
@property (nonatomic, readonly) UILabel         *label;

@end
