//
//  STTableViewTextView.h
//  SimpleTidbits
//
//  Created by Jason Gregori on 12/13/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBorderView.h"


@interface STTableViewTextView : STBorderView
@property (nonatomic, copy) NSString    *text;
@property (nonatomic, readonly) UILabel *label;
@end
