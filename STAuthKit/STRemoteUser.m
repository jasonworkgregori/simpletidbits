//
//  STRemoteUser.m
//  STAuthKit
//
//  Created by Jason Gregori on 10/17/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STRemoteUser.h"

#pragma mark Notifications
NSString *const STRemoteUserDidLoginNotification
  = @"STRemoteUserDidLoginNotification";
NSString *const STRemoteUserDidLogoutNotification
  = @"STRemoteUserDidLogoutNotification";

#pragma mark NSUserDefaults Keys
NSString *const STRemoteUserLoggedInKey = @"STRemoteUserLoggedIn";
NSString *const STRemoteUserUserInfoKey = @"STRemoteUserUserInfo";
NSString *const STRemoteUserAuthInfoKey = @"STRemoteUserAuthInfo";

static STRemoteUser *sharedInstance = nil; 


@interface STRemoteUser ()
@property (nonatomic, retain)
  id <STRemoteLoginControllerProtocol>  st_loginController;
@property (nonatomic, retain)
  id <STRemoteSignUpControllerProtocol> st_signUpController;
@property (nonatomic, retain) STRemoteData  *remoteData;
@end


@implementation STRemoteUser
@synthesize st_loginController = _loginController,
            st_signUpController = _signUpController, remoteData = _remoteData,
            signUpControllerIsModalOfLoginController
              = _signUpControllerIsModalOfLoginController;

#pragma mark Singleton stuff

+ (id)user
{
    if (!sharedInstance)
    {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone*)zone
{
    //Usually already set by +initialize.
    if (sharedInstance)
    {
        //The caller expects to receive a new object, so implicitly retain it
        //to balance out the eventual release message.
        return [sharedInstance retain];
    }
    else
    {
        //When not already set, +initialize is our caller.
        //It's creating the shared instance, let this go through.
        return [super allocWithZone:zone];
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX; // denotes an object that cannot be released
}

- (void)release
{
    // do nothing 
}

- (id)autorelease
{
    return self;
}

#pragma mark STRemoteUser

- (id)init
{
    // If sharedInstance is nil, +initialize is our caller, so initialze the
    // instance.
    // If it is not nil, simply return the instance without re-initializing it.
    if (!sharedInstance)
    {
        if (self = [super init])
        {
            //Initialize the instance here.
            self.signUpControllerIsModalOfLoginController   = YES;
        }
    }
    return self;
}

- (void)dealloc
{
    [_loginController release];
    
    [super dealloc];
}

- (BOOL)loggedIn
{
    return [[NSUserDefaults standardUserDefaults]
            boolForKey:STRemoteUserLoggedInKey];
}

- (id)userInfo
{
    return self.st_userInfo;
}

- (BOOL)login
{
    return [self loginWithMessage:nil];
}

- (BOOL)loginWithMessage:(NSString *)message
{
    if (self.loggedIn)
    {
        // we are already logged in
        return YES;
    }
    if (self.st_loginController)
    {
        // we must already be showing the login controller
        return NO;
    }
    
    self.st_loginController             = [self st_setUpLoginController];
    self.st_loginController.delegate    = self;
    self.st_loginController.message     = message;
    
    if (!self.st_loginController)
    {
        [NSException
         raise:@"STRemoteUser No Login Controller Exception"
         format:
         @"Did not get a Login Controller back from `st_setUpLoginController`, "
         @"%@",
         self];
    }
    
    return NO;
}

- (void)logout
{
    // get userinfo so we can send it in the notification
    id      userInfo        = [self.userInfo retain];

    // remove all our user data
    NSUserDefaults  *defaults   = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:STRemoteUserLoggedInKey];
    [defaults removeObjectForKey:STRemoteUserUserInfoKey];
    [defaults removeObjectForKey:STRemoteUserAuthInfoKey];
    // save
    [defaults synchronize];
    
    // send notification
    [[NSNotificationCenter defaultCenter]
     postNotificationName:STRemoteUserDidLogoutNotification
     object:self
     userInfo:userInfo];
    
    [userInfo release];
}

// Used to authenticate remote data requests, must be overridden by subclasses.
// Default does nothing.
- (void)authenticateRemoteDataRequest:(STRemoteData *)remoteData
{
    
}

#pragma mark Subclass Methods

- (void)setSt_userInfo:(id)userInfo
{
    NSUserDefaults  *userDefaults   = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userInfo forKey:STRemoteUserUserInfoKey];
    [userDefaults synchronize];
}

- (id)st_userInfo
{
    return [[NSUserDefaults standardUserDefaults]
            objectForKey:STRemoteUserUserInfoKey];
}

- (void)setSt_authInfo:(id)authInfo
{
    NSUserDefaults  *userDefaults   = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:authInfo forKey:STRemoteUserAuthInfoKey];
    [userDefaults synchronize];
}

- (id)st_authInfo
{
    return [[NSUserDefaults standardUserDefaults]
            objectForKey:STRemoteUserAuthInfoKey];
}

- (void)st_setUserAsLoggedIn
{
    // save
    NSUserDefaults  *userDefaults   = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:STRemoteUserLoggedInKey];
    [userDefaults synchronize];
    
    // send notification
    [[NSNotificationCenter defaultCenter]
     postNotificationName:STRemoteUserDidLoginNotification
     object:self
     userInfo:self.userInfo];
}

// Required, return a login controller for STRemoteUser to show the user.
// Login Controllers are responsible for signup as well.
// STRemoteUser will set itself to the delegate of the controller, so override
// the delegate calls if you need to (but make sure you call super)
- (id <STRemoteLoginControllerProtocol>)st_setUpLoginController
{
    return nil;
}

// Required, sets up the STRemoteData request for logging in.
// Will only be called if a user actually tells the login controller to login,
// not if the user cancels or signs up instead.
- (STRemoteData *)st_setUpLoginRequest:
  (id <STRemoteLoginControllerProtocol>)loginController
{
    return nil;
}

// Required if your app has signup capability. Returns a signup controller to
// show the user. STRemoteUser will set itself to the delegate of the
// controller, so override the delegate calls if you need to (but make sure you
// call super). Will only be called if a user wants to sign up, not if he
// cancels.
- (id <STRemoteSignUpControllerProtocol>)st_setUpSignUpController
{
    return nil;
}

// Required if your app has signup capability. Sets up the STRemoteData request
// for signing up. Will only be called if a user wants to sign up, not if he
// cancels.
- (STRemoteData *)st_setUpSignUpRequest:
  (id <STRemoteSignUpControllerProtocol>)signUpController
{
    return nil;
}

// Optional, only called if there is no error in logging in.
// This method is responsible for marking the user as logged in or not and
// saving any necessary auth info.
// The default is to mark the user as logged in and save the response object
// as st_authInfo.
- (void)st_loginUserWithRemoteDataResponse:(STRemoteData *)remoteData
{
    self.st_authInfo    = remoteData.responseData;
    [self st_setUserAsLoggedIn];
}

#pragma mark -
#pragma mark Delegate Methods
#pragma mark STRemoteLoginControllerDelegate

- (void)remoteLoginControllerTryLogin:
  (id <STRemoteLoginControllerProtocol>)loginController
{
    self.remoteData = [self st_setUpLoginRequest:loginController];
    if (!self.remoteData)
    {
        return;
    }
    self.st_loginController.loading = YES;
    self.remoteData.authenticated   = NO;
    self.remoteData.delegate        = self;
    [self.remoteData get];
}

- (void)remoteLoginControllerCancel:
  (id <STRemoteLoginControllerProtocol>)loginController
{
    [self.st_loginController hide];
    self.st_loginController    = nil;
}

- (void)remoteLoginControllerUserWantsToSignUp:
  (id <STRemoteLoginControllerProtocol>)loginController
{
    if (!self.signUpControllerIsModalOfLoginController)
    {
        [self.st_loginController hide];
        self.st_loginController     = nil;
    }

    self.st_signUpController            = [self st_setUpSignUpController];
    self.st_signUpController.delegate   = self;
    
    if (!self.st_signUpController)
    {
        [NSException
         raise:@"STRemoteUser No SignUp Controller Exception"
         format:
         @"Did not get a SignUp Controller back from "
         @"`st_setUpSignUpController` even though signup was allowed.\n%@",
         self];
    }
}

#pragma mark STRemoteSignUpControllerDelegate

- (void)remoteSignUpControllerTrySignUp:
  (id <STRemoteSignUpControllerProtocol>)signUpController
{
    self.remoteData = [self st_setUpSignUpRequest:signUpController];
    if (!self.remoteData)
    {
        return;
    }
    signUpController.loading        = YES;
    self.remoteData.authenticated   = NO;
    self.remoteData.delegate        = self;
    [self.remoteData get];
}

- (void)remoteSignUpControllerCancel:
  (id <STRemoteSignUpControllerProtocol>)signUpController
{
    if (self.signUpControllerIsModalOfLoginController)
    {
        [self.st_loginController hide];
        self.st_loginController     = nil;
    }
    else
    {
        [self.st_signUpController hide];
    }
    
    self.st_signUpController    = nil;
}

#pragma mark STRemoteDataDelegate

- (void)remoteDataDidFail:(STRemoteData *)remoteData
{
    // login did fail, show the message to the user in the login
    NSString    *errorMessage   = remoteData.errorMessage;
    if (!errorMessage)
    {
        errorMessage    = @"An error has occured, please try again.";
    }
    
    if (self.st_signUpController)
    {
        // we are in the sign up screen
        // show an alert, let the user try again
        self.st_signUpController.loading    = NO;
        [UIAlertView st_showAlertViewWithTitle:@"Sign Up Error"
                                       message:errorMessage];
    }
    else
    {
        // we are in the login screen
        self.st_loginController.message    = errorMessage;
        // let the user try and log in again
        self.st_loginController.loading    = NO;
    }
    
    self.remoteData     = nil;
}

- (void)remoteDataDidFinish:(STRemoteData *)remoteData
{
    [self st_loginUserWithRemoteDataResponse:remoteData];
    
    // hide sign up or login
    if (self.st_signUpController)
    {
        // we are in sign up
        if (self.signUpControllerIsModalOfLoginController)
        {
            [self.st_loginController hide];
            self.st_loginController = nil;
        }
        else
        {
            [self.st_signUpController hide];
        }
        self.st_signUpController    = nil;
    }
    else
    {
        // we are in login
        [self.st_loginController hide];
        self.st_loginController = nil;
    }
    
    self.remoteData         = nil;
}

@end
