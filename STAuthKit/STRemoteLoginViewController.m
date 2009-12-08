//
//  STRemoteLoginViewController.m
//  STAuthKit
//
//  Created by Jason Gregori on 10/18/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STRemoteLoginViewController.h"


@implementation STRemoteLoginViewController
@synthesize delegate = _delegate, message = _message, username = _username,
            password = _password, showSignUpOption = _showSignUpOption,
            showCancelOption = _showCancelOption, loading = _loading;


- (void)dealloc
{
    [_message release];
    [_username release];
    [_password release];
    [_usernameLabel release];
    [_passwordLabel release];
    
    [super dealloc];
}

#pragma mark For Subclass Use
// Automatically calls delegate for each of these.
- (void)st_login
{
    [self.delegate remoteLoginControllerTryLogin:self];
}

- (void)st_signUp
{
    [self.delegate remoteLoginControllerUserWantsToSignUp:self];
}

// Calls `hide` as well
- (void)st_cancel
{
    [self.delegate remoteLoginControllerCancel:self];
    [self hide];
}

#pragma mark STRemoteLoginControllerProtocol

- (void)show
{
    
}

- (void)hide
{
    
}

@end
