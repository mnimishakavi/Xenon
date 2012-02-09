//
//  App_LoginScreenVC.h
//  Xenon
//
//  Created by Mahendra on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//This class handles the initial Authentication of the User

//Currently dummy verification will be replaced by Network Authentication

#import <UIKit/UIKit.h>
#import "AuthenticationService.h"
#import "App_ViewController.h"

@interface App_LoginScreenVC : App_ViewController<UITextFieldDelegate,authenticationServiceDelegate>
{
    IBOutlet UITextField* userNameField;
    IBOutlet UITextField* passWordField;
    IBOutlet UIButton*    signInButton;
    
    //root Tab which manages the navigation of entire app
    IBOutlet UITabBarController* rootTabController;
}

@property(nonatomic,retain)UITextField* userNameField;
@property(nonatomic,retain)UITextField* passWordField;
@property(nonatomic,retain)UIButton* signInButton;

@property(nonatomic,retain)UITabBarController* rootTabController;

-(IBAction)onSignInButtonClicked:(id)sender;

-(void)authenticateUser:(NSString*)userName Password:(NSString*)passWord;




@end
