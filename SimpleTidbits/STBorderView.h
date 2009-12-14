//
//  STBorderView.h
//  SimpleTidbits
//
//  Created by Jason Gregori on 12/9/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 
 STBorderView just creates a border around whatever view you want.
 
 */

@interface STBorderView : UIView
{
    UIView          *_contentView;
    UIEdgeInsets    _margins;
}


@property (nonatomic, retain)   UIView          *contentView;

// The margins around the content view. The margins default to 10.
@property (nonatomic, assign)   UIEdgeInsets    margins;

@end
