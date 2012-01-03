//
//  FifthViewController.m
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalViewController.h"
#import "AppDelegate.h"
#import "SyncTableViewController.h"
#import "PrefTableViewController.h"
#import "MyAdsTableViewController.h"


@implementation PersonalViewController

@synthesize segmentedControl, activeViewController, segmentedViewControllers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Profil", @"Profil");
        self.tabBarItem.image = [UIImage imageNamed:@"user"];
        [self setTitle:@"Personal"];
        
        //setarea butoanelor din navbar
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(goHome)]autorelease];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"homepage.png"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)goHome
{AppDelegate *apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [apdelegate goToHomeScreen];
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITableViewController *syncView = [[SyncTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UITableViewController *prefView = [[PrefTableViewController alloc] init];
    UITableViewController *myAdsView = [[MyAdsTableViewController alloc] init];
    
    self.segmentedViewControllers = [NSArray arrayWithObjects:syncView,prefView,myAdsView, nil];
    [syncView release];
    [prefView release];
    [myAdsView release];
    
    self.navigationItem.titleView = self.segmentedControl = 
    [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Sync",@"Preferences",@"My Ads", nil]];
    self.segmentedControl.tintColor = [UIColor darkGrayColor];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.segmentedControl.frame = CGRectMake(0, 0, 400, 30.0);    
    
    [self.segmentedControl addTarget:self action:@selector(didChangeSegmentControl:) forControlEvents:UIControlEventValueChanged];
    
    [self didChangeSegmentControl:self.segmentedControl]; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.activeViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.activeViewController viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.activeViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.activeViewController viewDidDisappear:animated];
}

/*
#pragma mark UINavigationControllDelegate control

- (void) navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [viewController viewDidAppear:animated];
}

- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [viewController viewWillAppear:animated];	
}
 */

#pragma mark Segment control

- (void) didChangeSegmentControl:(UISegmentedControl *)control{
    if (self.activeViewController) {
        [self.activeViewController viewWillDisappear:NO];
        [self.activeViewController.view removeFromSuperview];
        [self.activeViewController viewDidDisappear:NO];
    }
    
    self.activeViewController = [self.segmentedViewControllers objectAtIndex:control.selectedSegmentIndex];
    
    [self.activeViewController viewWillAppear:NO];
    [self.view addSubview:self.activeViewController.view];
    [self.activeViewController viewDidAppear:NO];
}


#pragma mark Memory management

- (void)dealloc {
    self.segmentedControl = nil;
    self.segmentedViewControllers = nil;
    self.activeViewController = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
