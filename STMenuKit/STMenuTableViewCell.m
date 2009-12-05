//
//  STMenuTableViewCell.m
//  STMenuKit
//
//  Created by Jason Gregori on 11/21/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STMenuTableViewCell.h"
#import "STMenuBaseTableViewController.h"
#import "STMenuMaker.h"

static NSMutableDictionary *st_classForCellClassName = nil;

@implementation STMenuTableViewCell
@synthesize key = _key, menu = _menu;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // Initialization code
    }
    return self;
}


- (void)dealloc
{
    [_key release];
    
    [super dealloc];
}

+ (CGFloat)heightWithTitle:(NSString *)title value:(id)value
{
    return 44;
}

- (void)st_prepareForReuse
{
    
}

- (void)cellWasSelected
{
    
}

// title is copied, defaults to setting textLabel.text to title
- (void)setTitle:(NSString *)title
{
    self.textLabel.text = title;
}

// defaults to setting defaultTextLabel.text to [value description]
- (void)setValue:(id)value
{
    self.detailTextLabel.text   = [value description];
}

#pragma mark STATIC methods

+ (void)initialize
{
    if (self == [STMenuTableViewCell class])
    {
        st_classForCellClassName    = [[NSMutableDictionary alloc] init];
    }
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass(self);
}

+ (Class)classForCellData:(id)data
             defaultClass:(Class)defaultClass
{
    return [self classForCellClassName:[STMenuMaker classNameForData:data]
                          defaultClass:defaultClass];
}

+ (Class)classForCellClassName:(NSString *)className
                  defaultClass:(Class)defaultClass
{
    if (!className)
    {
        return defaultClass;
    }
    
    Class   class   = [st_classForCellClassName valueForKey:className];
    if (class != NULL)
    {
        return class;
    }
    
    class   = [STMenuMaker classFromClassName:className
                                   withPrefix:@"STMenu"
                                       suffix:@"TableViewCell"];
    if (class == NULL)
    {
        class   = [STMenuMaker classFromClassName:className
                                       withPrefix:nil
                                           suffix:@"TableViewCell"];
    }
    if (class == NULL)
    {
        class   = [STMenuMaker classFromClassName:className];
    }
    if (class == NULL)
    {
        [NSException raise:@"STMenuFormattedTableViewController cell maker"
                    format:@"Could not find class for class name:\n%@",
         className];            
    }
    [st_classForCellClassName setValue:class forKey:className];
    return class;
}

#pragma mark -
#pragma mark UITableViewCell



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
