//
//  STRemoteLoginControllerProtocol.h
//  STAuthKit
//
//  Created by Jason Gregori on 10/18/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 STRemoteLoginControllerProtocol
 -------------------------------
 
 Follow this protocol if you want to make a custom Login Controller. It does
 not have to be a view controller or a view. But it must be able to show the
 user a login screen.
 
 Login Controllers are designed to be able to be created then shown and
 released like UIAlertViews so keep this in mind when creating one.
 
 Login Controllers should:
 
 * Take over the screen and not allow the user to touch anything except it
 * Have a place for the user to type in their username and password
 * Show a login button
 * (Optionally) Have the option to show a cancel button
 * (Optionally) Have the option to show a sign up button
 * (Optionally) Display a message to the user (eg: "Login to view bla")
 
 */

@protocol STRemoteLoginControllerDelegate;


@protocol STRemoteLoginControllerProtocol <NSObject>

// Use to tell the user hit login or signup
@property (nonatomic, assign)   id <STRemoteLoginControllerDelegate> delegate;

// message to show user in login screen
@property (nonatomic, copy)     NSString        *message;
// When loading == YES, your login view should become unusable but stay on
// screen. You should show some indicator that loading is happening (e.g.: a
// spinner).
@property (nonatomic, assign)   BOOL            loading;

// Hide the login
- (void)dismiss;

@end


@protocol STRemoteLoginControllerDelegate <NSObject>

- (void)remoteLoginControllerTryLogin:
  (id <STRemoteLoginControllerProtocol>)loginController;
- (void)remoteLoginControllerCancel:
  (id <STRemoteLoginControllerProtocol>)loginController;
- (void)remoteLoginControllerUserWantsToSignUp:
  (id <STRemoteLoginControllerProtocol>)loginController;

@end

