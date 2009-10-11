//
//  STNetworkIndicator.h
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/27/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 The goal of STNetworkIndicator is to have a nested version of UIApplication's
 networkActivityIndicatorVisible. This way you can show network usage without
 having to keep track of every object that is using the network.
 
 
 
 In addition to this, STNetworkIndicator allows you to have different "network
 spaces" that can each have their own network count. This allows you to show
 network usage differently in different places. For example, you might show
 the user network usage only for what is going on in the current view.
 
 STNetworkIndicator sends notifications when the network has stopped being
 used (for individual network spaces or the entire application network).
 This is helpful for staggering network usage. For example, as long as there
 is no network usage I will continue to download images the user will probably
 view later.
 
 Unless otherwise noted, using nil as a network namespace param uses the
 entire application network.
 
 Because of all the storing and copying of strings I recommend that you use
 constant non mutable strings for network namespaces.
 
 STNetworkIndicator is a singleton and as such you should use the method
 sharedNetworkIndicator to use it.
 */
@interface STNetworkIndicator : NSObject
{
  @protected
	NSString		*_currentNetworkNamespace;
	NSCountedSet	*namespaceNetworkUsages;
}
// use this property to show network usage for a particular namespace
// defaults to nil (entire application network)
@property (nonatomic, copy)		NSString	*currentNetworkNamespace;

+ (id)sharedNetworkIndicator;

- (BOOL)isNetworkBeingUsed;
- (BOOL)isNetworkBeingUsedForNamespace:(NSString *)networkNamespace;

// if nil is used for networkNamespace, STNetworkIndicatorGeneralNamespace
// replaces it. In inc... string is copied.
- (void)incrementNetworkUsageForNamespace:(NSString *)networkNamespace;
- (void)decrementNetworkUsageForNamespace:(NSString *)networkNamespace;

// checks if the network is being used, and if it is not, sends a notification
- (void)checkNetworkUsage;
- (void)checkNetworkUsageForNamespace:(NSString *)networkNamespace;

@end

// This namespace is used if nil is provided the for inc/dec methods
extern NSString *const STNetworkIndicatorGeneralNamespace;

// Notifications
/* 
 The STNetworkIndicatorApplicationNetworkNoLongerInUse notification means that
 the application network is no longer in use.
 */
extern NSString *const STNetworkIndicatorApplicationNetworkNoLongerInUse;
/*
 The STNetworkIndicatorNamespaceNetworkNoLongerInUse notification means that
 the namespace network is no longer in use. The namespace will be provided
 in the userInfo of the notification for the key STNetworkIndicatorNamespaceKey.
 */
extern NSString *const STNetworkIndicatorNamespaceNetworkNoLongerInUse;
extern NSString *const STNetworkIndicatorNamespaceKey;

