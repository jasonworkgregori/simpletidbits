//
//  STRemoteLoginViewController.h
//  STAuthKit
//
//  Created by Jason Gregori on 10/18/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <SimpleTidbits/SimpleTidbits.h>
#import <STMenuKit/STMenuKit.h>
#import "STRemoteLoginControllerProtocol.h"

/*
 
 STRemoteLoginViewController
 ---------------------------
 
 This is a default View Controller version of a Login Controller.

 It is a sample Login that you may use if you don't want to make one.
 
 The default plist is in the bundle. Use it as a starting point or include
 the bundle in your project and set the plist to
 @"STRemoteKit.bundle/STRemoteLogin.plist".
 
 */

@interface STRemoteLoginViewController : STMenuFormTableViewController
<STRemoteLoginControllerProtocol>
{
  @protected
    id <STRemoteLoginControllerDelegate> _delegate;
    BOOL            _signUpButtonHidden;
    BOOL            _cancelButtonHidden;
    
    UIBarButtonItem *_cancelButton;
    STBorderView    *_loginButton;
    UIBarButtonItem *_signUpButton;
    
    STTableViewTextView *_messageView;
}
// default signup button hidden
@property (nonatomic, assign)   BOOL    signUpButtonHidden;
// default cancel button showing
@property (nonatomic, assign)   BOOL    cancelButtonHidden;

- (void)setSignUpButtonHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)setCancelButtonHidden:(BOOL)hidden animated:(BOOL)animated;

- (void)login;
- (void)cancel;
- (void)signUp;

@end
