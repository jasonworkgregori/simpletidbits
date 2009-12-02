//
//  STMenuTableViewCell.h
//  STMenuKit
//
//  Created by Jason Gregori on 11/21/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STMenuBaseTableViewController;

@interface STMenuTableViewCell : UITableViewCell
{
    NSString        *_key;
    STMenuBaseTableViewController   *_menu;
}
@property (nonatomic, copy) NSString    *key;
@property (nonatomic, assign)   STMenuBaseTableViewController   *menu;

+ (Class)classForCellData:(id)data
             defaultClass:(Class)defaultClass;
+ (Class)classForCellClassName:(NSString *)className
                  defaultClass:(Class)defaultClass;

+ (CGFloat)heightWithTitle:(NSString *)title value:(id)value;

- (void)st_prepareForReuse;
- (void)cellWasSelected;

// title is copied, defaults to setting textLabel.text to title
- (void)setTitle:(NSString *)title;
// defaults to setting defaultTextLabel.text to [value description]
- (void)setValue:(id)value;

@end
