//
//  STRemoteLoginViewController.m
//  STAuthKit
//
//  Created by Jason Gregori on 10/18/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STRemoteLoginViewController.h"

@interface STRemoteLoginViewController ()
@property (nonatomic, retain)   UIBarButtonItem *st_cancelButton;
@property (nonatomic, retain)   STBorderView    *st_loginButton;
@property (nonatomic, retain)   UIBarButtonItem *st_signUpButton;

@property (nonatomic, retain)   STTableViewTextView *st_messageView;

@end


@implementation STRemoteLoginViewController
@synthesize delegate = _delegate, cancelButtonHidden = _cancelButtonHidden,
            signUpButtonHidden = _signUpButtonHidden,
            st_cancelButton = _cancelButton, st_loginButton = _loginButton,
            st_signUpButton = _signUpButton, st_messageView = _messageView;

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style])
    {
        // set default value
        self.value      = [NSMutableDictionary dictionary];
        
        // set login button
        // if we should show the sign up button, but it doesn't exist
        UIButton    *button     = [UIButton
                                   buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self
                   action:@selector(login)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"Login" forState:UIControlStateNormal];
        STBorderView    *view   = [[STBorderView alloc]
                                   initWithFrame:CGRectMake(0, 0, 320, 64)];
        view.contentView        = button;
        self.st_loginButton        = view;
        [view release];
        
        // set default options
        self.cancelButtonHidden = NO;
        self.signUpButtonHidden = YES;
    }
    return self;
}

- (void)dealloc
{
    [_messageView release];
    [_cancelButton release];
    [_signUpButton release];
    [_loginButton release];
    
    [super dealloc];
}

// Automatically calls delegate for each of these.
- (void)login
{
    [self.tableView
     deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow]
     animated:YES];
    [self.delegate remoteLoginControllerTryLogin:self];
}

- (void)signUp
{
    [self.delegate remoteLoginControllerUserWantsToSignUp:self];
}

// Calls `hide` as well
- (void)cancel
{
    [self.delegate remoteLoginControllerCancel:self];
}

#pragma mark Properties

- (void)setCancelButtonHidden:(BOOL)hidden
{
    [self setCancelButtonHidden:hidden animated:NO];
}

- (void)setCancelButtonHidden:(BOOL)hidden animated:(BOOL)animated
{
    _cancelButtonHidden = hidden;
    if (!_cancelButtonHidden && !self.st_cancelButton)
    {
        // if we should show the cancel button, but it does not exist
        UIBarButtonItem *button = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:
                                   UIBarButtonSystemItemCancel
                                   target:self
                                   action:@selector(cancel)];
        self.st_cancelButton   = button;
        [button release];
        [self.navigationItem setLeftBarButtonItem:self.st_cancelButton
                                         animated:animated];
    }
    else if (_cancelButtonHidden && self.st_cancelButton)
    {
        // if the cancel button should hide and it exists
        [self.navigationItem setLeftBarButtonItem:nil
                                         animated:animated];
        self.st_cancelButton   = nil;
    }
}

- (void)setSignUpButtonHidden:(BOOL)hidden
{
    [self setSignUpButtonHidden:hidden animated:NO];
}

- (void)setSignUpButtonHidden:(BOOL)hidden animated:(BOOL)animated
{
    _signUpButtonHidden = hidden;
    if (!_signUpButtonHidden && !self.st_signUpButton)
    {
        UIBarButtonItem *button = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Sign Up"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(signUp)];
        self.st_signUpButton   = button;
        [button release];
        [self.navigationItem setRightBarButtonItem:self.st_signUpButton
                                          animated:animated];
    }
    else if (_signUpButtonHidden && self.st_signUpButton)
    {
        [self.navigationItem setRightBarButtonItem:nil
                                          animated:animated];
        self.st_signUpButton   = nil;
    }
}

#pragma mark STRemoteLoginControllerProtocol

- (NSString *)message
{
    return self.st_messageView.text;
}

- (void)setMessage:(NSString *)message
{
    if (message && !self.st_messageView)
    {
        STTableViewTextView *textView   = [[STTableViewTextView alloc]
                                           init];
        textView.margins    = UIEdgeInsetsMake(10, 10, 0, 10);
        self.st_messageView    = textView;
        [textView release];
    }
    else if (!message && self.st_messageView)
    {
        self.st_messageView    = nil;
    }
    
    // set message text
    self.st_messageView.text   = message;
    if ([self isViewLoaded])
    {
        // show/hide message view
        self.tableView.tableHeaderView  = self.st_messageView;
    }
}

- (void)dismiss
{
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark STMenuBaseTableViewController

- (void)setLoading:(BOOL)loading
{
    [super setLoading:loading];
}

- (BOOL)loading
{
    return [super loading];
}

- (void)setLoading:(BOOL)loading animated:(BOOL)animated
{
    [super setLoading:loading animated:animated];
    
    self.st_signUpButton.enabled   = !loading;
    self.st_cancelButton.enabled   = !loading;
}

#pragma mark UIViewController

- (void)loadView
{
    [super loadView];
    
    self.tableView.tableHeaderView  = self.st_messageView;
    self.tableView.tableFooterView  = self.st_loginButton;
}

@end
