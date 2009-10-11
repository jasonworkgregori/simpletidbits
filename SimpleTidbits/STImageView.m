//
//  STImageView.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 10/8/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STImageView.h"
#import <QuartzCore/QuartzCore.h>

@interface STImageView ()
@property (nonatomic, retain)	STFileCache		*fileCache;

@end


@implementation STImageView
@synthesize	url = _url, backgroundImageName = _backgroundImageName,
			animateReadilyAvailableImages = _animateReadilyAvailableImages,
			clearImageWhenLoadingNextImage = _clearImageWhenLoadingNextImage,
			fileCache = _fileCache, networkNamespace = _networkNamespace;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
	{
        // Initialization code
		self.animateReadilyAvailableImages	= YES;
		self.clearImageWhenLoadingNextImage	= YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame networkNamespace:(NSString *)networkNamespace
{
	if (self = [self initWithFrame:frame])
	{
		_networkNamespace	= [networkNamespace copy];
	}
	return self;
}

- (void)dealloc
{
	[_fileCache release];
	[_url release];
	[_backgroundImageName release];
	[_networkNamespace release];
	
    [super dealloc];
}

- (void)setImage:(UIImage *)image
{
	[self setImage:image animated:NO];
}

- (void)setImage:(UIImage *)image animated:(BOOL)animated
{
	if (!image && self.backgroundImageName)
	{
		// if we failed to load a new image, load the background default one
		image	= [UIImage imageNamed:self.backgroundImageName];
	}
	
	if (image != self.image)
	{
		[super setImage:image];
		
		if (animated)
		{
			CATransition	*animation	= [CATransition animation];
			animation.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
			animation.duration			= 0.7;
			[self.layer addAnimation:animation forKey:nil];
		}
	}
	
	if (!self.fileCache)
	{
		// reset url because this was not set by the cache
		[_url release];
		_url		= nil;
	}
}

- (void)clearImageViewAnimated:(BOOL)animated
{
	self.fileCache	= nil;
	[self setImage:nil animated:animated];
}

- (void)setUrl:(NSString *)url
{
	if ([self.url isEqualToString:url])
	{
		return;
	}
	
	[_url release];
	_url		= [url copy];
	
	if (self.url && [self.url length] > 0)
	{
		STFileCache		*cache		= [[STFileCache alloc] initWithURL:self.url
											   networkNamespace:self.networkNamespace];
		cache.delegate	= self;
		self.fileCache	= cache;
		[cache release];
		
		if (![self.fileCache downloaded] && self.clearImageWhenLoadingNextImage)
		{
			// if the image isn't already downloaded and the user wants to, clear
			[self setImage:nil animated:NO];
		}
		
		// ???: animateReadilyAvailableImages may not work without performing after delay
		[self.fileCache start];
	}
	else
	{
		// they must not have a url for this imageView, clear
		[self clearImageViewAnimated:self.animateReadilyAvailableImages];
	}
}


#pragma mark -
#pragma mark Delegate Methods
#pragma mark STFileCacheDelegate Methods

- (void)fileCacheDidFail:(STFileCache *)fileCache
{
	if (fileCache == self.fileCache)
	{
		// clear
		[self setImage:nil animated:(!fileCache.fileWasCached || self.animateReadilyAvailableImages)];
		self.fileCache	= nil;
	}
}

- (void)fileCache:(STFileCache *)fileCache didFinishWithData:(NSData *)data
{
	if (fileCache == self.fileCache)
	{
		// load up new image
		[self setImage:[UIImage imageWithData:data]
			  animated:(!fileCache.fileWasCached || self.animateReadilyAvailableImages)];
		self.fileCache	= nil;
	}	
}

@end

















