//
//  STRemoteSignUpControllerProtocol.h
//  STAuthKit
//
//  Created by Jason Gregori on 12/07/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 STRemoteSignUpControllerProtocol
 --------------------------------
 
 Follow this protocol if you want to make a custom Sign Up Controller. It does
 not have to be a view controller or a view. But it must be able to show the
 user a sign up screen.
 
 Sign Up Controllers are designed to be able to be created then shown and
 released like UIAlertViews so keep this in mind when creating one.
 
 Sign Up Controllers should:
 
 * Take over the screen and not allow the user to touch anything except it
 * Have a place for the user to type in their sign up information
 * Show a sign up button
 * (Optionally) Have the option to show a cancel button
 
 */

@protocol STRemoteSignUpControllerDelegate;


@protocol STRemoteSignUpControllerProtocol <NSObject>

// Use to tell the user hit signup
@property (nonatomic, assign)   id <STRemoteSignUpControllerDelegate> delegate;

// When loading == YES, your login view should become unusable but stay on
// screen. You should show some indicator that loading is happening (e.g.: a
// spinner).
@property (nonatomic, assign)   BOOL            loading;

// Hide the sign up screen
- (void)dismiss;

@end


@protocol STRemoteSignUpControllerDelegate <NSObject>

- (void)remoteSignUpControllerTrySignUp:
  (id <STRemoteSignUpControllerProtocol>)signUpController;
- (void)remoteSignUpControllerCancel:
  (id <STRemoteSignUpControllerProtocol>)signUpController;

@end

