//
//  STFileCache.h
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/29/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNetworkIndicator.h"
#import "STSimpleURLConnection.h"

/*
 The goal of STFileCache is to allow the developer to easily download files
 and have them cached locally if they are needed again later.
 
 
 
 The caching is completely hidden from the developer. Just give STFileCache
 a url and it will return the data later. The cached files are stored in the
 caches directory, so the system will purge them if necessary. Any files that
 get old will be removed automatically.
 
 To set the amount of days a file will be kept until it is discarded set the
 STFileCacheDaysToKeepFiles key in you info.plist file to the number of days
 you want to save them for. If a file is reused before the days are up, it's
 count will restart. The default is a week (7).
 */

@protocol STFileCacheDelegate;

@interface STFileCache : NSObject
{
  @protected
	id <STFileCacheDelegate> _delegate;
	NSString		*_path;
	NSURL			*_url;
	NSString		*_networkNamespace;
	BOOL			_fileWasCached;
	BOOL			_done;
	NSData			*_data;
	BOOL			_successful;
	BOOL			_continueDownloadEvenIfTerminated;
	id				_context;
}

@property (nonatomic, assign)			id			delegate;
// Path to where the file will be stored.
@property (nonatomic, readonly)			NSString	*path;
@property (nonatomic, readonly)			NSURL		*url;
@property (nonatomic, copy, readonly)	NSString	*networkNamespace;
@property (nonatomic, assign, readonly)	BOOL		fileWasCached;
// Whether or not the fileCache has finished.
@property (nonatomic, readonly)			BOOL		done;
// Once done, returns YES if we have data.
@property (nonatomic, readonly)			BOOL		successful;
// The actual data.
@property (nonatomic, readonly)			NSData		*data;
// If YES the file will continue downloading even if the fileCache is released.
// YES is the default. You may want to set it to NO if you are downloading a
// large file and don't want to waste bandwidth once the user navigates away.
@property (nonatomic, assign)			BOOL		continueDownloadEvenIfTerminated;
// For any use
@property (nonatomic, retain)			id			context;

// Url is copied
- (id)initWithURL:(NSString *)url;
- (id)initWithURL:(NSString *)url networkNamespace:(NSString *)networkNamespace;
- (void)start;

// Returns YES if the file is downloaded. Works even before the fileCache has
// been started.
- (BOOL)downloaded;

// checking if file is cached
//+ (BOOL)fileCached:(NSString *)url;
//+ (NSData *)dataCached:(NSString *)url;

@end


@protocol STFileCacheDelegate <NSObject>
- (void)fileCacheDidFail:(STFileCache *)fileCache;
- (void)fileCache:(STFileCache *)fileCache didFinishWithData:(NSData *)data;
@end
