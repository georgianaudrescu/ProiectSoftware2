//
//  ViewController.m
//  PrimaPagina
//
//  Created by me on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"
#import "LoginViewController.h"

@implementation ViewController
@synthesize buttonAbout, buttonAplicatie;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  /*  
    UIImage *buttonImage = [UIImage imageNamed:@"search.png"];
    UIImageView *buttonImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(20, 15
, buttonImage.size.width*2, buttonImage.size.height*2)]autorelease];
                            
    [buttonImageView setImage:buttonImage];
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, buttonImage.size.height*2,100, buttonImage.size.height*2)]autorelease];
    titleLabel.text = @"Cauta anunturi";
    titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size: 11.0];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor= [UIColor clearColor];
    titleLabel.textAlignment = UITextAlignmentCenter;
   
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addSubview:buttonImageView];
    [button addSubview:titleLabel];
    [self.view addSubview:button];
   */
    ////
    
    
    
   
}
-(IBAction)selectPage:(UIButton*)aButton
{
    /*
    if([aButton.titleLabel.text isEqualToString:@" Login"])
        {
            LoginViewController *logViewController = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
            [self presentModalViewController:logViewController animated:YES];
        }
        else
        {}
    */
    
    AppDelegate *apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [apdelegate enterApplication];
    
   // [apdelegate pageSelected:aButton.titleLabel.text];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    
}

-(void) dealloc
{
    [buttonAbout release];
    [buttonAplicatie release];
    [super dealloc];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
