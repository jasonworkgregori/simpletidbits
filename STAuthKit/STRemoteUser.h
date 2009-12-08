//
//  STRemoteUser.h
//  STAuthKit
//
//  Created by Jason Gregori on 10/17/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STRemoteData.h"
#import "STRemoteLoginControllerProtocol.h"
#import "STRemoteSignUpControllerProtocol.h"

/*
 
 STRemoteUser
 ------------
 
 STRemoteUser is available for the following reasons:
 
 * Allows you to find out if the user is logged in.
 * Allows you to ask the user to login (or signup).
 * Allows STRemoteData to log the user out on an unauthorized error.
 
 STRemoteUser sends out a logged in notification on actual login OR when the
 shared instance is created and the user is already logged in.
 
 STRemoteUser sends out a logged out notification on `logout`.
 
 Subclassing
 -----------
 
 STRemoteUser __requires__ that you subclass in order to show the correct
 login as well as authenticate STRemoteData's requests.
 
 STRemoteUser is a singleton, so make sure you call your class first to make
 the singleton an instance of your class.
 
 */

#pragma mark Notifications

// For both notifications object is self, userInfo is self.userInfo
extern NSString *const STRemoteUserDidLoginNotification;
extern NSString *const STRemoteUserDidLogoutNotification;

@interface STRemoteUser : NSObject
<STRemoteLoginControllerDelegate, STRemoteSignUpControllerDelegate,
STRemoteDataDelegate>
{
  @private
    id <STRemoteLoginControllerProtocol>    _loginController;
    id <STRemoteSignUpControllerProtocol>   _signUpController;
    STRemoteData    *_remoteData;
    BOOL            _signUpControllerIsModalOfLoginController;
}
@property (nonatomic, assign, readonly) BOOL    loggedIn;
@property (nonatomic, retain, readonly) id      userInfo;
// If this is YES, the login controller is not hidden when the user asks to
// sign up but instead it is hidden when the sign up controller should be
// hidden. And the sign up controller is never hidden. The default is YES.
@property (nonatomic, assign)
  BOOL      signUpControllerIsModalOfLoginController;

// Singleton instance. Make sure this gets called on your subclass before
// it gets called on STRemoteUser so the instance is an instance of your
// subclass.
+ (id)user;

// If already logged in, returns YES and does nothing.
// This way you can do `if (login()) {do stuff;}`
- (BOOL)login;
// A message to show the user in the login screen
- (BOOL)loginWithMessage:(NSString *)message;
// On logout, a notification is sent and all user data is cleared
- (void)logout;

// Used to authenticate remote data requests, must be overridden by subclasses.
// Default does nothing.
- (void)authenticateRemoteDataRequest:(STRemoteData *)remoteData;



#pragma mark -
#pragma mark For Subclass Use Only


@property (nonatomic, retain, readonly)
  id <STRemoteLoginControllerProtocol>  st_loginController;
@property (nonatomic, retain, readonly)
  id <STRemoteSignUpControllerProtocol> st_signUpController;

// The following properties ONLY save if the user is logged in.
// On logout, they are cleared.
// We use `NSUserDefaults` to save this stuff, so you can only use property
// list objects, and any mutable stuff becomes immutable.

// `st_authInfo` is for saving any auth info you get back from the login/signup
// remoteData that you will need for authing other remoteData.
@property (nonatomic, retain)   id      st_authInfo;
// `st_userInfo` is for any user info you get back from the login/signup
// remoteData that is specific to the user, but might be useful to other
// classes. It is publicly available through `userInfo`.
@property (nonatomic, retain)   id      st_userInfo;

// Use to set the user as logged in.
- (void)st_setUserAsLoggedIn;

#pragma mark Override

/*
 
 N.B. You do not *have* to override these methods, instead you can do your own
 thing and just override loginWithMessage:, set the st_authInfo and/or
 st_userInfo, and call st_setUserAsLoggedIn. Or a variation of that
 
 */

// Required if you want actual authentication, used to authenticate
// STRemoteData requests. Default does nothing. Declared above.
// - (void)authenticateRemoteDataRequest:(STRemoteData *)remoteData;

// Required, return a login controller for STRemoteUser to show the user.
// STRemoteUser will set itself to the delegate of the controller, so override
// the delegate calls if you need to (but make sure you call super). The login
// controller should already be shown.
- (id <STRemoteLoginControllerProtocol>)st_setUpLoginController;

// Required, sets up the STRemoteData request for logging in.
// Will only be called if a user actually tells the login controller to login,
// not if the user cancels or signs up instead.
// Return nil if you want the user to continue editing the login.
// Perhaps he didn't fill out his password, or his username doesn't have enough
// characters. If you want, you may throw up a UIAlertView for an error.
- (STRemoteData *)st_setUpLoginRequest:
  (id <STRemoteLoginControllerProtocol>)loginController;

// Required if your app has signup capability. Returns a signup controller to
// show the user. STRemoteUser will set itself to the delegate of the
// controller, so override the delegate calls if you need to (but make sure you
// call super). Will only be called if a user wants to sign up, not if he
// cancels. The sign up Controller should already be shown.
- (id <STRemoteSignUpControllerProtocol>)st_setUpSignUpController;

// Required if your app has signup capability. Sets up the STRemoteData request
// for signing up. Will only be called if a user wants to sign up, not if he
// cancels.
- (STRemoteData *)st_setUpSignUpRequest:
  (id <STRemoteSignUpControllerProtocol>)signUpController;

// Optional, only called if there is no error in logging in.
// This method is responsible for marking the user as logged in or not and
// saving any necessary auth info.
// Make SURE you mark the user as logged in AFTER you save any user/auth info
// because that will trigger the notification.
// The default is to save the response object as st_authInfo then mark the user
// as logged in.
- (void)st_loginUserWithRemoteDataResponse:(STRemoteData *)remoteData;

@end










