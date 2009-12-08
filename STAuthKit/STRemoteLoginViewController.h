//
//  STRemoteLoginViewController.h
//  STAuthKit
//
//  Created by Jason Gregori on 10/18/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRemoteLoginControllerProtocol.h"

/*
 
 STRemoteLoginViewController
 ---------------------------
 
 This is a standard View Controller version of a Login Controller.

 It is here as a base class for login view controllers and just does a few
 small things for you.
 
 */

@interface STRemoteLoginViewController : UIViewController
<STRemoteLoginControllerProtocol>
{
  @protected
    id <STRemoteLoginControllerDelegate> _delegate;
    NSString        *_message;
    NSString        *_username;
    NSString        *_password;
    BOOL            _showSignUpOption;
    BOOL            _showCancelOption;
    BOOL            _loading;
    NSString        *_usernameLabel;
    NSString        *_passwordLabel;
}




#pragma mark For Subclass Use
// Automatically calls delegate for each of these.
- (void)st_login;
- (void)st_signUp;
// Calls `hide` as well
- (void)st_cancel;

@end
