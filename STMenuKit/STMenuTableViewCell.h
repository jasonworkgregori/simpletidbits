//
//  STMenuTableViewCell.h
//  STMenuKit
//
//  Created by Jason Gregori on 11/21/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STMenuBaseTableViewController.h"

@protocol STMenuTableViewCellDelegate;

@interface STMenuTableViewCell : UITableViewCell
{
    NSString        *_key;
    STMenuBaseTableViewController   *_menu;
    id <STMenuTableViewCellDelegate>    _delegate;
}
@property (nonatomic, copy)     NSString    *key;
@property (nonatomic, assign)   STMenuBaseTableViewController   *menu;
@property (nonatomic, assign)   id <STMenuTableViewCellDelegate>    delegate;


+ (Class)classForCellData:(id)data
             customPrefix:(NSString *)prefix
             defaultClass:(Class)defaultClass;
+ (Class)classForCellClassName:(NSString *)className
                  customPrefix:(NSString *)prefix
                  defaultClass:(Class)defaultClass;

// Defaults to class name, the only use is really to set it to nil so it can't
// be reused.
+ (NSString *)cellIdentifier;
+ (CGFloat)heightWithTitle:(NSString *)title value:(id)value;

- (void)st_prepareForReuse;

// ???: I thought we couldn't use setSelected:animated for this but I think
// we can so this is deprecated until I am sure.
- (void)cellWasSelected;

// title is copied, defaults to setting textLabel.text to title
- (void)setTitle:(NSString *)title;
// defaults to setting defaultTextLabel.text to [value description]
- (void)setValue:(id)value;

@end

@protocol STMenuTableViewCellDelegate <NSObject>

// cell should use this when/if value updates
- (void)menuTableViewCell:(STMenuTableViewCell *)cell
           didChangeValue:(id)newValue;

@end
