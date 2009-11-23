//
//  STMenuFormattedTableViewController.m
//  STMenuKit
//
//  Created by Jason Gregori on 11/12/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STMenuFormattedTableViewController.h"
#import "STMenuMaker.h"
#import "STMenuTableViewCell.h"

@interface STMenuFormattedTableViewController ()

@property (nonatomic, retain) NSMutableArray    *sections;
@property (nonatomic, assign) NSUInteger        subMenuSection;

@end


@implementation STMenuFormattedTableViewController
@synthesize st_keysToIndexPaths = _keysToIndexPaths;

- (id)initWithStyle:(UITableViewStyle)style
{
    // Override initWithStyle: if you create the controller programmatically and
    // want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style])
    {
        
    }
    return self;
}

- (void)dealloc
{
    [_sections release];
    
    [super dealloc];
}

- (void)st_resetKeysToIndexPaths
{
    self.st_keysToIndexPaths   = nil;
}

- (NSDictionary *)st_keysToIndexPaths
{
    if (!_keysToIndexPaths)
    {
        // build it
        NSMutableDictionary *newKeysToIndexPaths = [[NSMutableDictionary alloc]
                                                    init];
        // go through sections
        NSUInteger section, count = [self.st_schema count];
        for (section = 0; section < count; section++)
        {
            NSArray    *rows    = [[self.st_schema objectAtIndex:section]
                                        valueForKey:@"rows"];
            // go through row
            NSUInteger row, count = [rows count];
            for (row = 0; row < count; row++)
            {
                [newKeysToIndexPaths setValue:[NSIndexPath
                                               indexPathForRow:row
                                               inSection:section]
                                       forKey:[[rows objectAtIndex:row]
                                               valueForKey:@"key"]];
            }
        }
        
        self.st_keysToIndexPaths   = newKeysToIndexPaths;
        [newKeysToIndexPaths release];
    }
    return _keysToIndexPaths;
}

- (NSDictionary *)st_rowDataForKey:(NSString *)key
{
    return [self st_rowDataForIndexPath:
            [self.st_keysToIndexPaths valueForKey:key]];
}

- (NSDictionary *)st_rowDataForIndexPath:(NSIndexPath *)indexPath
{
    return [[[self.st_schema
              objectAtIndex:indexPath.section]
             valueForKey:@"rows"]
            objectAtIndex:indexPath.row];
}

#pragma mark KVO

- (void)startObservingValueForAllKeys
{
    for (NSString *key in [self.st_keysToIndexPaths allKeys])
    {
        [self.value addObserver:self
                     forKeyPath:key
                        options:0
                        context:NULL];
    }
}

- (void)stopObservingValueForAllKeys
{
    for (NSString *key in [self.st_keysToIndexPaths allKeys])
    {
        [self.value removeObserver:self
                        forKeyPath:key];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    // set submenu if it matches the key
    if ([self.st_subMenu.key isEqualToString:keyPath])
    {
        self.st_subMenu.value   = [self.value valueForKey:keyPath];
    }

    // see if there is a cell that matches this key available
    NSIndexPath     *indexPath  = [self.st_keysToIndexPaths
                                   valueForKey:keyPath];
    if (indexPath)
    {
        // set cell value
        id      cell   = [self.tableView cellForRowAtIndexPath:indexPath];
        [cell setValue:[self.value valueForKey:keyPath]
                forKey:keyPath];
    }
}

#pragma mark STMenuBaseTableViewController

- (void)st_saveValue:(id)value forSubMenuKey:(NSString *)key
{
    [self.value setValue:value forKey:key];
}

#pragma mark STMenuProtocol

- (void)setPlist:(id)plist andValue:(id)value
{
    [self stopObservingValueForAllKeys];
    [super setPlist:plist];
    [super setValue:value];
    [self startObservingValueForAllKeys];
    [self.tableView reloadData];
}

- (void)setPlist:(id)plist
{
    [self stopObservingValueForAllKeys];
    [super setPlist:plist];
    [self startObservingValueForAllKeys];
    [self.tableView reloadData];
}

- (void)setValue:(id)newValue
{
    [self stopObservingValueForAllKeys];
    [super setValue:newValue];
    [self startObservingValueForAllKeys];
    [self.tableView reloadData];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.st_schema count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[[self.st_schema objectAtIndex:section]
             valueForKey:@"rows"]
            count];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: get height from cell class
    return 44;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: move this stuff into a separate function so other subclasses can
    // use it.
    NSDictionary    *rowData    = [self st_rowDataForIndexPath:indexPath];
    NSString    *key        = [rowData valueForKey:@"key"];
    NSString    *className  = [STMenuMaker
                               classNameForData:[rowData valueForKey:@"cell"]];
    
    // see if there is already one
    STMenuTableViewCell *cell
      = (STMenuTableViewCell *)[tableView
                                dequeueReusableCellWithIdentifier:className];
    if (!cell)
    {
        // find the class
        Class   class   = [STMenuMaker classFromClassName:className
                                               withPrefix:@"ST"
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
        // create a cell
        cell    = [[[class alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:className]
                   autorelease];
    }

    if (!key || ![key isEqualToString:cell.key])
    {
        // set up the properties
        [STMenuMaker setInstance:cell properties:[rowData valueForKey:@"cell"]];
        
        // key
        cell.key        = key;
        // title
        cell.title      = [rowData valueForKey:@"title"];
        // value
        cell.value      = [self.value valueForKey:key];
        if (!cell.value)
        {
            // default value
            cell.value  = [rowData valueForKey:@"value"];
        }
    }
    
    // Set up the cell...
	
    return cell;
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This way the cell knows if it was selected and can do something about it.
    // If returns YES, check if we should scroll there
    [(id)[tableView cellForRowAtIndexPath:indexPath] cellWasSelected];
    
    NSDictionary    *rowData    = [self st_rowDataForIndexPath:indexPath];
    NSDictionary    *menu       = [rowData valueForKey:@"menu"];
    if (menu)
    {
        // if there is a menu, push it!
        NSString    *key        = [rowData valueForKey:@"key"];

        // get menu
        UIViewController <STMenuProtocol>   *subMenu = [self
                                                        st_getMenuFromData:menu
                                                        forKey:key];
        // set value
        subMenu.value   = [self.value valueForKey:key];
        // set title
        subMenu.title   = [rowData valueForKey:@"title"];
        
        // push it
        [self st_pushMenu:subMenu];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the
        // array, and add a new row to the table view
    }   
}
*/


@end

