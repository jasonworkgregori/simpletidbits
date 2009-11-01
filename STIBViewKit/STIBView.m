//
//  STIBView.m
//  STIBViewKit
//
//  Created by Jason Gregori on 10/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STIBView.h"

#import <Foundation/Foundation.h>
#import "STIBViewGenerator.h"

@interface STIBView ()

// actually create instance from nib
+ (id)ST_instanceFromNib;

@end

static BOOL ST_loadingFromClassNib = NO;

@implementation STIBView

/*
 We will be using nibs to create our views and IB will use initWithCoder to
 instantiate our view so we may override initWithFrame without fear of breaking
 IB.
 */
- (id)initWithFrame:(CGRect)frame
{
    // load up a new instance from nib
    id      newSelf    = [[[self class] ST_instanceFromNib] retain];
    
    // release this instance, because we are going to make a new one
    [self release];
    
    self    = newSelf;
    
    if (!CGRectEqualToRect(frame, CGRectZero))
    {
        self.frame      = frame;
    }
    
    return self;
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    // If this instance was loaded from a nib that was not our view nib,
    // we need to override and replace it with our guy

    if (ST_loadingFromClassNib)
    {
        ST_loadingFromClassNib  = NO;
        return self;
    }
    
    UIView      *newSelf     = [[[self class] instance] retain];
    
    // set it's info to be the properties of the view it is replacing
    newSelf.frame       = self.frame;
    newSelf.alpha       = self.alpha;
    newSelf.tag         = self.tag;
    
    for (UIView *view in self.subviews)
    {
        [newSelf addSubview:view];
    }
    
    [self release];
    
    return newSelf;
}

- (void)dealloc
{
    
    [super dealloc];
}


#pragma mark -
#pragma mark Class Methods

// The nibName to load the instance from. Defaults to class name.
// Override for new views.
+ (NSString *)nibName
{
    return NSStringFromClass(self);
}

// Generates an instance of our class
+ (id)instance
{
    return [[[self alloc] init] autorelease];
}

// Load an STIBView from a nib
+ (id)IBViewForNibNamed:(NSString *)nibName
{    
    STIBViewGenerator   *generator  = [STIBViewGenerator
                                       sharedSTIBViewGenerator];

    // Load the nib for the STIBView using our shared STIBViewGenerator
    // as the owner. This will connect the view to the sharedIBViewGenerator's
    // view outlet
    [[NSBundle mainBundle] loadNibNamed:nibName
                                  owner:generator
                                options:nil];
    // This is how we get the view from the sharedIBViewGenerator.
    // Make sure it's retained, then autorelease it.
    id      view       = [[generator.view retain] autorelease];
    // Release the view from the sharedIBViewGenerator so it won't wasting
    // memory after it isn't being used anymore.
    generator.view  = nil;
    
    return view;
}

#pragma mark Private

+ (id)ST_instanceFromNib;
{
    // we set this so we know we are loading from the class nib
    ST_loadingFromClassNib  = YES;
    return [STIBView IBViewForNibNamed:[self nibName]];
}

@end
