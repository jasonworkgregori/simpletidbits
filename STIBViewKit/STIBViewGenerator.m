//
//  STIBViewGenerator.m
//  STIBViewKit
//
//  Created by Jason Gregori on 10/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STIBViewGenerator.h"

static STIBViewGenerator *sharedIBViewGenerator = nil;

@implementation STIBViewGenerator
@synthesize view = _view;

+ (void)initialize
{
    if (!sharedIBViewGenerator)
    {
        sharedIBViewGenerator   = [[STIBViewGenerator alloc] init];
    }
}

// STIBViewGenerator is a singleton that can only be accessed internally.
- (id)init
{
    if (!sharedIBViewGenerator)
    {
        // initialize if we are creating our shared instance
        self = [super init];
        return self;
    }
    else
    {
        // only we can create an instance
        [self release];
        self = nil;
    }

    return self;
}

- (void)dealloc
{
    [_view release];
    
    [super dealloc];
}


+ (STIBViewGenerator *)sharedSTIBViewGenerator
{
    sharedIBViewGenerator.view  = nil;
    return sharedIBViewGenerator;
}

@end
