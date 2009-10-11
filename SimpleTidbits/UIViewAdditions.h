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

@property(nonatomic) CGFloat ST_left;
@property(nonatomic) CGFloat ST_top;
@property(nonatomic, readonly) CGFloat ST_right;
@property(nonatomic, readonly) CGFloat ST_bottom;

@property(nonatomic) CGFloat ST_width;
@property(nonatomic) CGFloat ST_height;

@property(nonatomic) CGSize	ST_size;

@end
