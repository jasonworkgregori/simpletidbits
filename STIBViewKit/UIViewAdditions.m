//
//  UIViewAdditions.m
//  STIBViewKit
//
//  Created by Jason Gregori on 11/1/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "UIViewAdditions.h"

#import "STIBViewGenerator.h"

@implementation UIView (STIBViewKit)

// Load a UIView from a nib
+ (id)ST_IBViewForNibNamed:(NSString *)nibName
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

@end
