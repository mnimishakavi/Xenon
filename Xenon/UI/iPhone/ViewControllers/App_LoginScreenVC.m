//
//  App_LoginScreenVC.m
//  Xenon
//
//  Created by Mahendra on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "App_LoginScreenVC.h"

@interface App_LoginScreenVC ()

//method to launch UI
-(void)launchUI;



@end

@implementation App_LoginScreenVC

@synthesize userNameField;
@synthesize passWordField;
@synthesize signInButton;
@synthesize rootTabController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    
    RELEASE_TO_NIL(userNameField);
    RELEASE_TO_NIL(passWordField);
    RELEASE_TO_NIL(signInButton);
    RELEASE_TO_NIL(rootTabController);
    [super dealloc];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    RELEASE_TO_NIL(userNameField);
    RELEASE_TO_NIL(passWordField);
    RELEASE_TO_NIL(signInButton);
    RELEASE_TO_NIL(rootTabController);
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //configure the keyboard look and functions
    
    self.userNameField.keyboardType = UIKeyboardTypeDefault;
    self.userNameField.returnKeyType = UIReturnKeyNext;
    [self.userNameField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.userNameField setKeyboardAppearance:UIKeyboardAppearanceAlert];
    self.userNameField.delegate = self;
    
    self.passWordField.keyboardType = UIKeyboardTypeDefault;
    self.passWordField.returnKeyType = UIReturnKeyDone;
    [self.passWordField setSecureTextEntry:YES];
    [self.passWordField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.passWordField setKeyboardAppearance:UIKeyboardAppearanceAlert];
    self.passWordField.delegate = self;
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark getter method for Tab
- (UITabBarController *)rootTabController {
	if (rootTabController == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"RootTab" owner:self options:nil];
        rootTabController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        rootTabController.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return rootTabController;
}

#pragma mark Actions
//Sign In Clicked pick the user credentials and authenticate
-(IBAction)onSignInButtonClicked:(id)sender
{

#ifndef DEVELOPMENT   
    [self.userNameField resignFirstResponder];
    [self.passWordField resignFirstResponder];
    
    
    if(([self.userNameField.text length]<1))
    {
        [App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:@"User Name Can't be left Blank"];
        return;
    }
    
    if(([self.passWordField.text length]<1))
    {
        [App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:@"Password Can't be left Blank"];
        return;
    }
//    NSLog(@"Username is %@",self.userNameField.text);
//    NSLog(@"passWordField is %@",self.passWordField.text);
    
    [self authenticateUser:self.userNameField.text Password:self.passWordField.text];
#endif
    
#ifdef DEVELOPMENT
    [self launchUI];
#endif
    
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	
	
	if (textField == self.userNameField )
	{
		[ self.passWordField  becomeFirstResponder];
		
	}
	else
	{
        
		[self.userNameField resignFirstResponder];
        [self.passWordField resignFirstResponder];
        
               
	
    
        if(([self.userNameField.text length]<1))
        {
            [App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:@"User Name Can't be left Blank"];
            return NO;
        }
        
        if(([self.passWordField.text length]<1))
        {
            [App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:@"Password Can't be left Blank"];
            return NO;
        }

        [self showHUD:@"Authenticating User"];
        [self authenticateUser:self.userNameField.text Password:self.passWordField.text];
    }
    
	return YES;
}

-(void)authenticateUser:(NSString*)userName Password:(NSString*)passWord
{
    [self showHUD:@"Authenticating User"];
    AuthenticationService* service = [[AuthenticationService alloc] init];
    service.delegate = self;
    [service authenticateUserWithUserName:userName Password:passWord];
}


-(void)launchUI
{
    [self presentModalViewController:self.rootTabController animated:YES];
}


#pragma mark Authentication Delegate
-(void)signInDidPass
{
    [self dismissHUD];
    //[App_GeneralUtilities showAlertOKWithTitle:@"Success" withMessage:@"Valid User"];
    [self launchUI];
    
    
}

-(void)signInDidFail:(NSError *)error
{
    [self dismissHUD];
    [App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:[error localizedDescription]];
}


@end
