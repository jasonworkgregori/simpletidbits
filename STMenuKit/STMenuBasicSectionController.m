//
//  STMenuBasicSectionController.m
//  STMenuKit
//
//  Created by Jason Gregori on 11/22/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STMenuBasicSectionController.h"

@interface STMenuBasicSectionController ()

// we need to keep the values as well so we can stop observing on them when
// we're done
@property (nonatomic, retain) id        values;
@property (nonatomic, retain) NSArray   *keys;

@end


@implementation STMenuBasicSectionController
@synthesize rows = _rows, values = _values, keys = _keys;

- (void)dealloc
{
    // need to make sure we stop observing this stuff
    [self menuValueDidChange:nil];
    [_rows release];
    [_keys release];
    
    [super dealloc];
}

- (void)setRows:(NSArray *)rows
{
    // this can only be set once!
    if (!_rows)
    {
        [_rows release];
        _rows   = [rows copy];
        
        self.keys   = [rows valueForKey:@"key"];
        
        [self menuValueDidChange:self.menu.value];
    }
    else
    {
        [NSException
         raise:@"STMenuBasicSectionController setRows"
         format:@"Rows may only be sent ONCE! (This is the second setting)"];
    }

}

- (void)menuValueDidChange:(id)newValue
{
    if (!self.rows)
    {
        // this cannot be set before the rows are set
        return;
    }
    
    // KVO on values
    NSMutableSet    *encounteredKeys    = [NSMutableSet set];
    NSUInteger i, count = [self.rows count];
    for (i = 0; i < count; i++)
    {
        NSString    *key    = [[self.rows objectAtIndex:i] valueForKey:@"key"];
        // make sure we haven't already done this one
        if (![encounteredKeys containsObject:key])
        {
            // stop observing old value
            [self.values removeObserver:self forKeyPath:key];
            
            // set default values
            id      defaultValue    = [[self.rows objectAtIndex:i]
                                       valueForKey:@"defaultValue"];
            if (newValue && defaultValue && ![newValue valueForKey:key])
            {
                [newValue setValue:defaultValue
                            forKey:key];
            }
            
            // start observing new value
            [newValue addObserver:self
                       forKeyPath:key
                          options:0
                          context:NULL];
            
            [encounteredKeys addObject:key];
        }
    }
    
    // retain new value
    self.values     = newValue; 
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (self.values == object && [self.keys containsObject:keyPath])
    {
        // reload cells for this keyPath
        NSRange     range;
        range.location  = 0;
        range.location  = [self.keys count];
        NSUInteger      row;
        NSMutableArray  *rows   = [NSMutableArray array];
        while (range.location < [self.keys count] &&
               (row = [self.keys indexOfObject:keyPath inRange:range])
               != NSNotFound)
        {
            [rows addObject:
             [NSIndexPath indexPathForRow:row inSection:self.section]];

            // changing the range to search for any matches past here
            range.location  = row+1;
            range.length    = [self.keys count] - range.location;
        }
        
        // reload cells
        [self.menu.tableView
         reloadRowsAtIndexPaths:rows
         withRowAnimation:UITableViewRowAnimationFade];
        
        // change value of subMenu if applicable
        if ([self.menu.st_subMenu.key isEqualToString:keyPath])
        {
            self.menu.st_subMenu.value = [self.values valueForKey:keyPath];
        }
    }
    else
    {
        // if this isn't our value OR we don't have this keyPath
        [object removeObserver:self forKeyPath:keyPath];
    }
}

// submenus
- (void)saveValue:(id)value forSubMenuKey:(NSString *)key
{
    [self.values setValue:value forKey:key];
}

// cells
- (NSInteger)numberOfRows
{
    return [self.rows count];
}

- (UITableViewCellEditingStyle)editingStyleForRow:(NSUInteger)row
{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)shouldIndentWhileEditingRow:(NSUInteger)row
{
    return NO;
}

// for subclasses
- (NSString *)titleForRow:(NSUInteger)row
{
    return [[self.rows objectAtIndex:row] valueForKey:@"title"];
}

- (id)valueForRow:(NSUInteger)row
{
    return [self.values valueForKey:[self keyForRow:row]];
}

- (id)cellDataForRow:(NSUInteger)row
{
    return [[self.rows objectAtIndex:row] valueForKey:@"cell"];
}

- (NSString *)keyForRow:(NSUInteger)row
{
    return [[self.rows objectAtIndex:row] valueForKey:@"key"];
}

- (id)menuDataForRow:(NSUInteger)row
{
    return [[self.rows objectAtIndex:row] valueForKey:@"menu"];
}

@end
