//
//  UIViewAdditions.h
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (SimpleTidbits)

@property(nonatomic) CGFloat st_left;
@property(nonatomic) CGFloat st_top;
@property(nonatomic, readonly) CGFloat st_right;
@property(nonatomic, readonly) CGFloat st_bottom;

@property(nonatomic) CGFloat st_width;
@property(nonatomic) CGFloat st_height;

@property(nonatomic) CGSize	st_size;

@end
