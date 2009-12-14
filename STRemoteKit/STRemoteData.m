//
//  STRemoteData.m
//  STAuthKit
//
//  Created by Jason Gregori on 10/12/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STRemoteData.h"

#import "STRemoteUser.h"

@interface STRemoteData ()
// Request
@property (nonatomic, retain)   NSMutableURLRequest     *request;
@property (nonatomic, retain)   STSimpleURLConnection   *connection;

// Response
@property (nonatomic, assign)	NSInteger       statusCode;
@property (nonatomic, retain)	id              responseData;
@property (nonatomic, retain)	NSString        *errorMessage;

- (void)st_transformRequestDictionaryToHTTPData;

@end

static NSString *st_STRemoteDataUserAgent	= nil;
static CGFloat	st_STRemoteTimeoutInterval	= 10;

@implementation STRemoteData
@synthesize	authenticated = _authenticated, delegate = _delegate,
			context = _context, request = _request, statusCode = _statusCode,
			responseData = _responseData, errorMessage = _errorMessage,
            networkNamespace = _networkNamespace, connection = _connection,
            requestDictionary = _requestDictionary;

#pragma mark Class Initialize

+ (void)initialize
{
	// make sure this only gets called once for this class
	if (self == [STRemoteData class])
	{
		// set up global variables
		NSDictionary	*info		= [[NSBundle mainBundle] infoDictionary];
		st_STRemoteDataUserAgent	= [[info valueForKey:
                                        @"STRemoteDataUserAgent"]
                                       copy];
		if ([info valueForKey:@"STRemoteDataTimeoutInterval"])
		{
			st_STRemoteTimeoutInterval	= [[info valueForKey:
                                            @"STRemoteDataTimeoutInterval"]
                                           floatValue];
		}
	}
}

#pragma mark Init and Dealloc

- (id)init
{
    if (self = [super init])
    {
        _request    = [[NSMutableURLRequest alloc] init];
        [self.request setCachePolicy:NSURLCacheStorageNotAllowed];
        [self.request setHTTPShouldHandleCookies:NO];
        [self.request setTimeoutInterval:st_STRemoteTimeoutInterval];
        [self.request setHTTPMethod:@"POST"];
        if (st_STRemoteDataUserAgent)
        {
            [self.request setValue:st_STRemoteDataUserAgent
                forHTTPHeaderField:@"User-Agent"];
        }
        self.authenticated      = YES;
    }
    
    return self;
}

- (id)initWithURL:(NSString *)url
{
	if (self = [self init])
	{
		NSURL		*aURL		= [[NSURL alloc] initWithString:url];
		if (!aURL)
		{
			// if no url, return nil, this won't work
			[self release];
            self    = nil;
			return self;
		}
		[self.request setURL:aURL];
        [aURL release];
	}
	
	return self;
}

- (void)dealloc
{
	[_context release];
	[_request release];
	[_connection release];
	[_requestDictionary release];
	[_responseData release];
    
	
	[super dealloc];
}

// Sending Convience Methods
// For a one request
- (void)setRequestName:(NSObject *)name value:(NSObject *)value
{
    self.requestDictionary  = [NSDictionary dictionaryWithObject:value
                                                          forKey:name];
}

// start sending
- (void)get
{
    if (self.authenticated && ![[STRemoteUser user] loggedIn])
    {
        // This is an authenticated request, but the user is not logged in.
        NSLog(@"This should never happen. You tried to get an authenticated "
              @"request when no one was logged in.\n%@",
              self);
        [self st_parsedResponseOK:NO
                     unauthorized:YES
                       statusCode:0
                     responseData:nil
                     errorMessage:nil];
        [[STNetworkIndicator sharedNetworkIndicator]
         checkNetworkUsageForNamespace:self.networkNamespace];
        return;
    }
    
    [self st_massageRequest];
    
	if (self.authenticated)
	{
        [[STRemoteUser user] authenticateRemoteDataRequest:self];
	}
	
    // get the http data ready
    [self st_transformRequestDictionaryToHTTPData];
    
    // start downloading spinner
    [[STNetworkIndicator sharedNetworkIndicator]
     incrementNetworkUsageForNamespace:self.networkNamespace];
    
    // send request
    self.connection = [[[STSimpleURLConnection alloc]
                        initWithRequest:self.request]
                       autorelease];
    self.connection.delegate    = self;
    [self.connection start];
}

- (void)st_transformRequestDictionaryToHTTPData
{
    if (self.requestDictionary)
    {
        // TODO: multipart
        NSData      *data       = [[self.requestDictionary st_URLEncodedForm]
                                   dataUsingEncoding:NSUTF8StringEncoding
                                   allowLossyConversion:YES];
        [self.request setValue:
         [NSString stringWithFormat:@"%lu", (unsigned long)[data length]]
            forHTTPHeaderField:@"Content-Length"];
        [self.request setHTTPBody:data];
    }
}


// Subclass __must__ call this after parse to tell STRemoteKit what you got or
// STRemoteData will not call delegate.
- (void)st_parsedResponseOK:(BOOL)OK
               unauthorized:(BOOL)unauthorized
                 statusCode:(NSInteger)statusCode
               responseData:(id)responseData
               errorMessage:(NSString *)errorMessage
{
	self.statusCode		= statusCode;
    self.errorMessage   = errorMessage;
    self.responseData   = responseData;
	
    if (unauthorized && self.authenticated)
    {
        // need to call delegate before we log out so they can clean things up
		[self.delegate remoteDataDidFail:self];
        // logout
		[[STRemoteUser user] logout];
        // show user an alert
		[UIAlertView
         st_showAlertViewWithTitle:@"Expired Session"
         message:@"Your session has expired, please login again"];
		return;
    }
    
    if (OK)
	{
		// tell the delegate
		[self.delegate remoteDataDidFinish:self];
	}
	else
    {
        [self.delegate remoteDataDidFail:self];
    }
}

#pragma mark -
#pragma mark Subclass Method and Response

// Overriding Optional.
// Use this if you need to do anything to the data before sending that does not
// require auth. This will be called before STRemoteUser authenticates the data.
// Default does nothing;
- (void)st_massageRequest
{
    
}

// Overriding Required.
// If there is a URLConnection failure, will not be called.
// Called when we get a response, subclass is responsible for parsing
- (void)st_handleResponse:(NSURLResponse *)httpResponse data:(NSData *)data
{
	// should never be called because subclass should override
	[NSException
     raise:@"STRemoteData Bad Subclass Exception"
     format:
     @"The handleResponse: method was called even though it should have been "
     @"overridden by a subclass.\n%@",
	 [self description]];
}

#pragma mark -
#pragma mark NSObject

- (NSString *)description
{
	NSString	*sent		= [[[NSString alloc] initWithData:
                                [self.request HTTPBody]
                                             encoding:NSUTF8StringEncoding]
                               autorelease];
	NSString	*received	= [self.responseData description];
	return [NSString stringWithFormat:
            @"URL: %@\nRequest Dictionary: %@\nSent Data: %@"
            @"\nReceived Data: %@",
            [self.request URL], self.requestDictionary, sent, received];
}

#pragma mark -
#pragma mark Delegate Methods
#pragma mark STSimpleURLConnectionDelegate

- (void)simpleURLConnectionDidFinishLoading:(STSimpleURLConnection *)connection
{
    [connection retain];
    self.connection = nil;
    [[STNetworkIndicator sharedNetworkIndicator]
     decrementNetworkUsageForNamespace:self.networkNamespace];
    [self st_handleResponse:connection.response data:connection.data];
    [connection release];
}

- (void)simpleURLConnection:(STSimpleURLConnection *)connection
           didFailWithError:(NSError *)error
{
    [[STNetworkIndicator sharedNetworkIndicator]
     decrementNetworkUsageForNamespace:self.networkNamespace];
    self.connection = nil;
    NSLog(@"STRemoteData ERROR:\n%@\n\nself:\n%@", error, self);
    [self st_parsedResponseOK:NO
                 unauthorized:NO
                   statusCode:0
                 responseData:nil
                 errorMessage:nil];
}

@end
