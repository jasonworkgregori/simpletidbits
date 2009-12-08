//
//  STRemoteData.h
//  STAuthKit
//
//  Created by Jason Gregori on 10/12/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SimpleTidbits/SimpleTidbits.h>

/*
 
 STRemoteData
 ------------
 
 STRemoteData allows you to send/get data to/from a remote source.
 
 STRemoteData comes with support for server side error checking. STRemoteData
 will tell you if there was an error. You don't need to check the response
 every time to see if it is actually an error message.
 
 STRemoteData also supports authenticated calls using STRemoteUser.
 STRemoteData will cause authenticated calls to fail if a user is not logged in
 and automatically log the user out if it gets an unauthorized error back from
 the server. STRemoteData asks STRemoteUser to authenticate requests that need
 it.
 
 Right before sending the request, STRemoteData will turn the requestDictionary
 (if used) into a urlencoded form and place it into the HTTP data.
 
 Subclassing
 -----------
 
 STRemoteData __requires__ that you subclass it in order to translate the
 response from the server into what STRemoteData needs. This is so it can be
 used with any different server configurations or APIs.
 
 Things your subclass should get out of your response:
 
 * Whether or not the result is good (OK).
 * Whether the call was unauthorized.
 * A Status Code, (optional) may be used by delegate if desired.
 * An Error Message  
   Any error message you hand back to STRemoteData will be made available to
   the delegate. What I like to do is only return error messages for user errors
   (eg: not enough characters in a password). Or if the delegate sees there
   is no error message, it can write a generic one for that specific case.
 * Actual Data  
   Depending on your service, the data you get back *should* be translated
   into an object for the delegate to use. This is made available to your
   delegate.
 
 Global Customization
 --------------------
 
 You can use the following keys in your `info.plist` file to customize
 STRemoteData's behavior.

 * `STRemoteDataUserAgent`  
   string, used as a custom User-Agent value. Defaults to none.
 * `STRemoteDataTimeoutInterval`  
   double, timeout in seconds. Defaults to 10.
 
 */

@protocol STRemoteDataDelegate;

@interface STRemoteData : NSObject <STSimpleURLConnectionDelegate>
{
  @private
	BOOL		_authenticated;
	id <STRemoteDataDelegate> _delegate;
	id			_context;
    NSString    *_networkNamespace;
	
	NSMutableURLRequest		*_request;
	STSimpleURLConnection	*_connection;
	NSDictionary			*_requestDictionary;
	// BOOL					_multipart;
	
	NSUInteger	_statusCode;
	id			_responseData;
	NSString	*_errorMessage;
}
// Whether to use authentication or not, defaults to YES
@property (nonatomic, assign)	BOOL	authenticated;
@property (nonatomic, assign)	id <STRemoteDataDelegate> delegate;
// For you use only
@property (nonatomic, retain)	id		context;
@property (nonatomic, copy)     NSString    *networkNamespace;

// Sending
// Use the request to edit headers, HTTP method, or whatever
// Defaults to POST, no cache (because we store a file cache ourselves),
// User-Agent and timeout set to whats in your info.plist, and no cookie
// handling. Override `init` if you want to change the default.
@property (nonatomic, retain, readonly) NSMutableURLRequest	*request;
// Request Dictionary, typically you use this for your request data.
// Before it is sent, it is transcribed into your request.
// If you use this, the Content-Type and the HTTPData will be set on `get`.
// If you want to send custom data, you may do so using the `request`.
@property (nonatomic, copy)		NSDictionary	*requestDictionary;
// If `requestDictionary` is not nil, the following determines if it should be
// turned into a urlencoded form or a multipart post. Defaults to NO (form).
// TODO: multipart
//@property (nonatomic, assign)	BOOL	multipart;

// Response
@property (nonatomic, assign, readonly)	NSUInteger		statusCode;
@property (nonatomic, retain, readonly)	id				responseData;
@property (nonatomic, retain, readonly)	NSString		*errorMessage;

// convenience init for setting a string url, otherwise you init and manually
// set the NSURL for the request. Returns nil on bad url.
- (id)initWithURL:(NSString *)url;

// Sending Convience Methods
// For a one request
- (void)setRequestName:(NSObject *)name value:(NSObject *)value;

// send the request
- (void)get;



#pragma mark For Subclass Overriding

// Overriding Optional.
// Use this if you need to do anything to the data before sending that does not
// require auth. This will be called before STRemoteUser authenticates the data.
// Default does nothing;
- (void)st_massageRequest;

// Overriding Required.
// If there is a URLConnection failure, will not be called.
// Called when we get a response, subclass is responsible for parsing.
// Do NOT call super (just throws an exception)
- (void)st_handleResponse:(NSURLResponse *)httpResponse;

#pragma mark For Subclass Use Only
/*
 Subclass __must__ call this after parse to tell STRemoteKit what you got or
 STRemoteData will not call delegate. On OK == YES, calls remoteDataDidFinish:
 on delegate, else remoteDataDidFail:. On unauthorized, logs out, returns
 failure.
 */
- (void)st_parsedResponseOK:(BOOL)OK
               unauthorized:(BOOL)unauthorized
                 statusCode:(NSUInteger)statusCode
               responseData:(id)responseData
               errorMessage:(NSString *)errorMessage;

@end

@protocol STRemoteDataDelegate <NSObject>

- (void)remoteDataDidFail:(STRemoteData *)remoteData;
- (void)remoteDataDidFinish:(STRemoteData *)remoteData;

@end
