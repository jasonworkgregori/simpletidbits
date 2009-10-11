//
//  STImageView.h
//  SimpleTidbits
//
//  Created by Jason Gregori on 10/8/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STFileCache.h"

/*
 The goal of STImageView is to have an image view that you can just give a url
 to and have the image downloaded and cached automatically.
 */

@interface STImageView : UIImageView <STFileCacheDelegate>
{
  @protected
	STFileCache		*_fileCache;
	NSString		*_backgroundImageName;
	NSString		*_url;
	NSString		*_networkNamespace;
	BOOL			_animateReadilyAvailableImages;
	BOOL			_clearImageWhenLoadingNextImage;
}
// The url to load the image from.
@property (nonatomic, copy)		NSString	*url;
// The name of a default image to use if we do not have an image or are waiting.
// If nil, no image is used. The default is nil.
@property (nonatomic, copy)		NSString	*backgroundImageName;
// Determines whether we should animate the transition to a new image,
// if the image was already cached.
@property (nonatomic, assign)	BOOL		animateReadilyAvailableImages;
// Determines if when loading a new image, we should leave the current one up
// or "clear" it (go to the default background image).
@property (nonatomic, assign)	BOOL		clearImageWhenLoadingNextImage;
// The networkNamespace to use for STNetworkIndicator.
@property (nonatomic, copy, readonly)	NSString	*networkNamespace;

- (id)initWithFrame:(CGRect)frame networkNamespace:(NSString *)networkNamespace;
- (void)setImage:(UIImage *)image animated:(BOOL)animated;
- (void)clearImageViewAnimated:(BOOL)animated;

@end
