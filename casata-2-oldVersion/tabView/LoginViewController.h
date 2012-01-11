//
//  FifthViewController.h
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
IBOutlet UITextField *usernameTextField, *passwordTextField;
IBOutlet UIButton *loginButton;   
UIButton *closeButton;

BOOL logat;
}

@property (retain, nonatomic) IBOutlet UITextField *usernameTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic, retain) IBOutlet UIButton *closeButton;

-(IBAction)getRidOfKeyboard:(id)sender;
-(IBAction) clickBackground:(id) sender;
-(IBAction)login:(id)sender;
-(IBAction)closeModalViewController:(id)sender;

@end
