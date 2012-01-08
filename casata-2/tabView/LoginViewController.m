//
//  FifthViewController.m
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "TUser.h"
@implementation LoginViewController
@synthesize usernameTextField;
@synthesize passwordTextField;
@synthesize loginButton,closeButton;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = NSLocalizedString(@"Profil", @"Profil");
        //self.tabBarItem.image = [UIImage imageNamed:@"user"];
    }
    return self;
}

-(IBAction)getRidOfKeyboard:(id)sender
{ [sender resignFirstResponder];
}


-(IBAction) clickBackground:(id) sender{
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

- (IBAction)closeModalViewController:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)login:(id)sender

{    
    ///Test ptr userLogin
    ///login se finalizeaza cu succes
    ///dar apoi aplicatia este killed
    /*
    TUser *userobj=[[TUser alloc] init];
    NSString *s1=[ NSString alloc];
    NSString *s2=[ NSString alloc];
    
    s1=usernameTextField.text;
    
    s2 =passwordTextField.text;
    
    [userobj LogInUser:s1 LogInPass:s2];
    [userobj release];
    */
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    
}
-(void)dealloc
{[usernameTextField release];
    [passwordTextField release];
    [loginButton release];
    [closeButton release];
    [super dealloc];
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

@end
