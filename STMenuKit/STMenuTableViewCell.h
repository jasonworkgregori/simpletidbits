//
//  STMenuTableViewCell.h
//  STMenuKit
//
//  Created by Jason Gregori on 11/21/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface STMenuTableViewCell : UITableViewCell
{
    NSString        *_key;
    NSString        *_title;
    id              _value;
}
@property (nonatomic, copy) NSString    *key;
@property (nonatomic, copy) NSString    *title;
@property (nonatomic, retain) id        value;

+ (CGFloat)heightWithTitle:(NSString *)title value:(id)value;

- (void)st_prepareForReuse;
- (void)cellWasSelected;

@end
