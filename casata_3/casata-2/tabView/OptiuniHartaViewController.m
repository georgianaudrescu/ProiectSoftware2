//
//  OptiuniHartaViewController.m
//  casata
//
//  Created by me on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OptiuniHartaViewController.h"
#import "FiltreTableViewController.h"
#import "MoreOptionsViewController.h"

@implementation OptiuniHartaViewController
@synthesize segmentedControl, activeViewController, segmentedViewControllers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didChangeSegmentControl:(UISegmentedControl *)control {
    if (self.activeViewController) {
        [self.activeViewController viewWillDisappear:NO];
        [self.activeViewController.view removeFromSuperview];
        [self.activeViewController viewDidDisappear:NO];
    }
    
    self.activeViewController = [self.segmentedViewControllers objectAtIndex:control.selectedSegmentIndex];
    
    [self.activeViewController viewWillAppear:NO];
    [self.view addSubview:self.activeViewController.view];
    [self.activeViewController viewDidAppear:NO];
    
    //NSString * segmentTitle = [control titleForSegmentAtIndex:control.selectedSegmentIndex];
    // self.navigationItem.backBarButtonItem  = [[[UIBarButtonItem alloc] initWithTitle:segmentTitle style:UIBarButtonItemStylePlain target:nil action:nil]autorelease];
}
-(void)dealloc
{
    [segmentedControl release];
    [activeViewController release];
    [segmentedViewControllers release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.activeViewController viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.activeViewController viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.activeViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.activeViewController viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIViewController * controller1 = [[FiltreTableViewController alloc] initWithNibName:@"FiltreTableViewController" bundle:nil];
    UIViewController * controller2 = [[MoreOptionsViewController alloc] initWithNibName:@"MoreOptionsViewController" bundle:nil];
   // UIViewController * controller3 = [[AdaugaImaginiViewController alloc] initWithNibName:@"AdaugaImaginiViewController" bundle:nil];
    
    
    self.segmentedViewControllers = [NSArray arrayWithObjects:controller1,controller2, nil];
    [controller1 release];
    [controller2 release];
    //[controller3 release];
    
    
    self.navigationItem.titleView = self.segmentedControl =
    [[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Filtre",@"Optiuni", nil]]autorelease];
    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
