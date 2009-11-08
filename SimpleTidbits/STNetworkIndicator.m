//
//  STNetworkIndicator.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/27/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STNetworkIndicator.h"
#import <UIKit/UIKit.h>

// This namespace is used if nil is provided the for inc/dec methods
NSString *const STNetworkIndicatorGeneralNamespace = @"SimpleTidbitsNetworkIndicatorGeneralNamespace";

// Notifications
NSString *const STNetworkIndicatorApplicationNetworkNoLongerInUse = @"STNetworkIndicatorApplicationNetworkNoLongerInUse";
NSString *const STNetworkIndicatorNamespaceNetworkNoLongerInUse = @"STNetworkIndicatorNamespaceNetworkNoLongerInUse";
NSString *const STNetworkIndicatorNamespaceKey = @"STNetworkIndicatorNamespaceKey";

static STNetworkIndicator *sharedNetworkIndicator = nil;

@interface STNetworkIndicator ()

- (void)st_resetNetworkIndicatorVisibility;

@end


@implementation STNetworkIndicator
@synthesize currentNetworkNamespace = _currentNetworkNamespace;

+ (id)sharedNetworkIndicator
{
	if (!sharedNetworkIndicator)
	{
		sharedNetworkIndicator	= [[self alloc] init];
	}
	return sharedNetworkIndicator;
}

- (id)init
{
	if (sharedNetworkIndicator)
	{
		// singleton!
		[self dealloc];
		self = [sharedNetworkIndicator retain];
	}
	else if (self = [super init])
	{
		namespaceNetworkUsages	= [[NSCountedSet alloc] init];
	}
	return self;
}

- (void)dealloc
{
	[_currentNetworkNamespace release];
	[namespaceNetworkUsages release];
	
	[super dealloc];
}

- (void)setCurrentNetworkNamespace:(NSString *)networkNamespace
{
	if (_currentNetworkNamespace != networkNamespace)
	{
		[_currentNetworkNamespace release];
		_currentNetworkNamespace	= [networkNamespace copy];
		[self st_resetNetworkIndicatorVisibility];
	}
}

- (void)st_resetNetworkIndicatorVisibility
{
	NSUInteger	count;
	if (self.currentNetworkNamespace)
	{
		count		= [namespaceNetworkUsages countForObject:self.currentNetworkNamespace];
	}
	else
	{
		count		= [namespaceNetworkUsages count];
	}
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:(count != 0)];
}

- (BOOL)isNetworkBeingUsed;
{
	return [namespaceNetworkUsages count] != 0;
}

- (BOOL)isNetworkBeingUsedForNamespace:(NSString *)networkNamespace
{
	if (!networkNamespace)
	{
		return [self isNetworkBeingUsed];
	}
	return [namespaceNetworkUsages countForObject:networkNamespace] != 0;
}

// if nil is used for networkNamespace, STNetworkIndicatorGeneralNamespace
// replaces it.
- (void)incrementNetworkUsageForNamespace:(NSString *)networkNamespace
{
	if (!networkNamespace)
	{
		networkNamespace	= STNetworkIndicatorGeneralNamespace;
	}
	[namespaceNetworkUsages addObject:[[networkNamespace copy] autorelease]];
	[self st_resetNetworkIndicatorVisibility];
}

- (void)decrementNetworkUsageForNamespace:(NSString *)networkNamespace
{
	if (!networkNamespace)
	{
		[namespaceNetworkUsages removeObject:STNetworkIndicatorGeneralNamespace];
	}
	else
	{
		[namespaceNetworkUsages removeObject:networkNamespace];
	}
	[self checkNetworkUsageForNamespace:networkNamespace];
	[self st_resetNetworkIndicatorVisibility];
}

// checks if the network is being used, and if it is not, sends a notification
- (void)checkNetworkUsage
{
	if ([namespaceNetworkUsages count] == 0)
	{
		// send notification
		[[NSNotificationCenter defaultCenter] postNotificationName:STNetworkIndicatorApplicationNetworkNoLongerInUse
															object:self];
	}
}

- (void)checkNetworkUsageForNamespace:(NSString *)networkNamespace
{
	if (!networkNamespace)
	{
		[self checkNetworkUsage];
		return;
	}
	if ([namespaceNetworkUsages countForObject:networkNamespace] == 0)
	{
		// send notification
		[[NSNotificationCenter defaultCenter] postNotificationName:STNetworkIndicatorNamespaceNetworkNoLongerInUse
															object:self
														  userInfo:
		 [NSDictionary dictionaryWithObject:networkNamespace
									 forKey:STNetworkIndicatorNamespaceKey]];
	}
}

@end