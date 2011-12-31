//
//  AdaugAnuntViewController.m
//  casata
//
//  Created by me on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AdaugAnuntViewController.h"
#import "AppDelegate.h"

@implementation AdaugAnuntViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Adauga anunt", @"Adauga anunt");
        self.tabBarItem.image = [UIImage imageNamed:@"adauga_anunt"];
        [self setTitle:@"Adauga anunt"];
        
        //butoanele din navigation bar-ul de sus-> Home si Filtre
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(goHome)]autorelease];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"homepage.png"];
        
       
        //butonul care va aparea ca back button pt view-ul child care va fi pus in stiva peste view-ul curent
        UIBarButtonItem *inapoiButton = [[UIBarButtonItem alloc] initWithTitle:@"Inapoi" style:UIBarButtonItemStylePlain target:nil action:nil]; 
        
        inapoiButton.tintColor = [UIColor blackColor];
        
        self.navigationItem.backBarButtonItem= inapoiButton;          
        
        
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *) self.navigationItem.titleView;
    if(!titleView)
    {titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont boldSystemFontOfSize:20];
        //titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        titleView.textColor = [UIColor blackColor];
        self.navigationItem.titleView = titleView;
        [titleView release];
    }
    titleView.text = title;
    [titleView sizeToFit];
    
    
}

-(void)goHome
{AppDelegate *apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [apdelegate goToHomeScreen];
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
