//
//  AdaugAnuntViewController.m
//  casata
//
//  Created by me on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AdaugAnuntViewController.h"
#import "AppDelegate.h"
#import "DetaliiAdaugaAnuntViewController.h"
#import "LocalizareViewController.h"
#import "AdaugaImaginiViewController.h"

@implementation AdaugAnuntViewController
@synthesize segmentedControl, activeViewController, segmentedViewControllers;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Adauga anunt", @"Adauga anunt");
        self.tabBarItem.image = [UIImage imageNamed:@"adauga_anunt"];
        [self setTitle:@"Adauga anunt"];
        
        
        
        
        // segmented control as the custom title view
       /*
        NSArray *segmentTextContent = [NSArray arrayWithObjects:
                                       NSLocalizedString(@"Anunt", @""),
                                       NSLocalizedString(@"Localizare", @""),
                                       NSLocalizedString(@"Imagini", @""),
                                       nil];
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];        
        ///
        segmentedControl.selectedSegmentIndex = 0;
        
        
        
        ////
        segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        segmentedControl.frame = CGRectMake(0, 0, 400, 30.0);
        [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        
        
        segmentedControl.tintColor = [UIColor darkGrayColor];
        
        self.navigationItem.titleView = segmentedControl;
        
        [segmentedControl release];             
        
        */
    }
    return self;
}


-(void)dealloc
{
    [segmentedControl release];
    [activeViewController release];
    [segmentedViewControllers release];
    [super dealloc];
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


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
    
    UIViewController * controller1 = [[DetaliiAdaugaAnuntViewController alloc] initWithNibName:@"DetaliiAdaugaAnuntViewController" bundle:nil];
    UIViewController * controller2 = [[LocalizareViewController alloc] initWithNibName:@"LocalizareViewController" bundle:nil];
    UIViewController * controller3 = [[AdaugaImaginiViewController alloc] initWithNibName:@"AdaugaImaginiViewController" bundle:nil];
   
    
    self.segmentedViewControllers = [NSArray arrayWithObjects:controller1, controller2,controller3, nil];
    [controller1 release];
    [controller2 release];
    [controller3 release];
    
     
    self.navigationItem.titleView = self.segmentedControl =
    [[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Detalii", @"Localizare",@"Imagini",nil]]autorelease];
    
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
