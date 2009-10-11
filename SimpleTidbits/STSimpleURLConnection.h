//
//  STSimpleURLConnection.h
//  SimpleTidbits
//
//  Created by Jason Gregori on 9/29/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol STSimpleURLConnectionDelegate;

/*
 Just a simplified version of NSURLConnection.
 
 Give it a request and it will return the data.
 */
@interface STSimpleURLConnection : NSObject
{
  @protected
	id <STSimpleURLConnectionDelegate> _delegate;
	id		_context;
	id		_subContext;
	NSURLConnection	*URLConnection;
	NSMutableData	*_data;
}
@property (nonatomic, assign)	id <STSimpleURLConnectionDelegate> delegate;
// For any use
@property (nonatomic, retain)	id		context;
@property (nonatomic, retain)	id		subContext;
// The response data
@property (nonatomic, readonly)	NSData	*data;

- (id)initWithRequest:(NSURLRequest *)request;
- (void)start;

@end

@protocol STSimpleURLConnectionDelegate <NSObject>

- (void)simpleURLConnectionDidFinishLoading:(STSimpleURLConnection *)connection;
- (void)simpleURLConnection:(STSimpleURLConnection *)connection didFailWithError:(NSError *)error;

@end