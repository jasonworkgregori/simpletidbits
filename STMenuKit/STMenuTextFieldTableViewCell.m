//
//  STMenuTextFieldTableViewCell.m
//  STMenuKit
//
//  Created by Jason Gregori on 12/4/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STMenuTextFieldTableViewCell.h"

#define kSTMenuTextFieldMaxWidth    175

@interface STMenuTextFieldTableViewCell ()
@property (nonatomic, retain) UITextField *textField;

- (void)st_deselectIfNotSelectedCell;
- (void)st_textFieldValueDidChange;

@end


@implementation STMenuTextFieldTableViewCell
@synthesize textField = _textField;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    if (style == UITableViewCellStyleDefault)
    {
        // we do this because we copy styles from the detailTextLabel
        style   = UITableViewCellStyleValue1;
    }
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle     = UITableViewCellSelectionStyleNone;
        _textField              = [[UITextField alloc] init];
        // This is only enabled when the cell is selected, that way the cell is
        // selected even when the textField is tapped. We need this behavior
        // so we can cleanup when the cell is deselected.
        _textField.enabled      = NO;
        _textField.contentVerticalAlignment
          = UIControlContentVerticalAlignmentCenter;
        _textField.autoresizingMask = (UIViewAutoresizingFlexibleHeight
                                       | UIViewAutoresizingFlexibleLeftMargin);
        _textField.delegate     = self;
        _textField.textColor    = self.detailTextLabel.textColor;
        _textField.adjustsFontSizeToFitWidth    = YES;
        _textField.minimumFontSize  = 13;
        _textField.returnKeyType= UIReturnKeyDefault;
        [self.contentView addSubview:_textField];
        
        // observe the textfield for changes
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(st_textFieldValueDidChange)
         name:UITextFieldTextDidChangeNotification
         object:_textField];
    }
    return self;
}

- (void)dealloc
{
    [_textField release];
    // make sure we aren't still listening for notifications
    [[NSNotificationCenter defaultCenter]
     removeObserver:self];
    
    [super dealloc];
}

- (void)st_deselectIfNotSelectedCell
{
    if ([self.menu.tableView cellForRowAtIndexPath:
         [self.menu.tableView indexPathForSelectedRow]]
        != self)
    {
        [self setSelected:NO animated:YES];
    }
}
         
- (void)st_textFieldValueDidChange
{
    [self.delegate menuTableViewCell:self didChangeValue:self.textField.text];
}

#pragma mark STMenuTableViewCell

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    // For moving the textLabel to the correct spot
    [self setNeedsLayout];
}

- (void)setValue:(id)value
{
    NSAssert(!value || [value isKindOfClass:[NSString class]],
             @"Value for STMenuTextFieldTableViewCell must be an NSString.");
    if (![value isEqualToString:self.textField.text])
    {
        self.textField.text = value;
    }
}

#pragma mark UITableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected)
    {
        // when selected, start editing
        self.textField.enabled  = YES;
        [self.textField becomeFirstResponder];
        
        // when set selected, listen for notifications of the tableView
        // changing selected cell we can resignFirstResponder. We need to do
        // because if the cell is off the screen it won't be told to deselect
        // when another cell is selected
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(st_deselectIfNotSelectedCell)
         name:UITableViewSelectionDidChangeNotification
         object:self.menu.tableView];
    }
    else
    {
        // if unselected, stop being first responder
        [self.textField resignFirstResponder];
        self.textField.enabled  = NO;
        
        // stop observing tableView
        [[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:UITableViewSelectionDidChangeNotification
         object:nil];
    }
}

#pragma UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.textLabel.text)
    {
        // move textfield over a bit
        CGFloat     width   = (self.contentView.bounds.size.width - 30
                               - self.textLabel.bounds.size.width);
        if (width > kSTMenuTextFieldMaxWidth)
        {
            width   = kSTMenuTextFieldMaxWidth;
        }
        self.textField.frame
        = CGRectMake(self.contentView.bounds.size.width - 10 - width,
                     0,
                     width,
                     self.contentView.bounds.size.height);
    }
    else
    {
        self.textField.frame    = CGRectInset(self.contentView.bounds, 10, 0);
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return self.selected;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // end editing, deselect cell
    [self.menu.tableView
     deselectRowAtIndexPath:[self.menu.tableView indexPathForCell:self]
     animated:NO];
    return NO;
}

@end
