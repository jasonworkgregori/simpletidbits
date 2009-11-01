//
//  STSimpleURLConnection.m
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/29/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STSimpleURLConnection.h"

@interface STSimpleURLConnection ()
@property (nonatomic, retain) NSURLResponse *response;

@end


@implementation STSimpleURLConnection
@synthesize delegate = _delegate, context = _context, subContext = _subContext,
			data = _data, response = _response;

- (id)initWithRequest:(NSURLRequest *)request
{
	if (self = [super init])
	{
		_URLConnection	= [[NSURLConnection alloc] initWithRequest:request
														delegate:self
												startImmediately:NO];
		if (!_URLConnection)
		{
			[self release];
            self    = nil;
			return nil;
		}
		_data			= [[NSMutableData alloc] init];
	}
	return self;
}

- (void)dealloc
{
	[_URLConnection cancel];
	[_URLConnection release];
	[_data release];
	[_context release];
	
	[super dealloc];
}

- (void)start
{
	[_URLConnection scheduleInRunLoop:[NSRunLoop currentRunLoop]
							 forMode:NSDefaultRunLoopMode];
	[_URLConnection start];
}

#pragma mark -
#pragma mark DELEGATE METHODS
#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.response    = response;
    [_data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[self.delegate simpleURLConnection:self didFailWithError:error];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection 
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
	// NO CACHEING!
	return nil;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[self.delegate simpleURLConnectionDidFinishLoading:self];
}

@end
