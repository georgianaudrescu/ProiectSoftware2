//
//  MyAdsViewController.m
//  casata
//
//  Created by Oana B on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyAdsViewController.h"

@implementation MyAdsViewController
@synthesize tableAds;
@synthesize headerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backToStatistics{
    
    //for animation
    //pozitia de plecare
    self.view.frame = CGRectMake(0,0, 320, 460);
    //pozitia finala
    [UIView animateWithDuration:0.5 
                     animations:^{self.view.frame = CGRectMake(-320,0, 320, 460);}
                     completion:^(BOOL completed){[self.view removeFromSuperview];}];
    
    
    
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//return [propertyTypes count];
    return 7;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
        cell.imageView.image = [UIImage imageNamed:@"house.jpg"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChecking:)];
    [cell.imageView addGestureRecognizer:tap];
    [tap release];
    
    //cell.textLabel.text = [ propertyTypes objectAtIndex:[indexPath row]];
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor blackColor];
    
    cell.selectedBackgroundView = backgroundView;
    [backgroundView release];
    
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    cell.textLabel.text = [NSString	 stringWithFormat:@"Anuntul meu %d", [indexPath row]];
    //cell.textLabel.text = [ propertyTypes objectAtIndex:[indexPath row]];
    
	//Create the button and add it to the cell
    
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self
			   action:@selector(publicaAnunt:)
	 forControlEvents:UIControlEventTouchDown];
	[button setTitle:@"Publica" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	button.frame = CGRectMake(240.0f, 5.0f, 70.0f, 30.0f);
    //acest buton va fi numai in randurile in care anunturile au fost modificate...
    if(([cell.textLabel.text isEqual:@"Anuntul meu 1"])||([cell.textLabel.text isEqual:@"Anuntul meu 5"])||([cell.textLabel.text isEqual:@"Anuntul meu 6"]))
    {
	[cell addSubview:button];
    }
    return cell;
}

-(void) publicaAnunt:(id)sender{
    //se publica anuntul selectat din lista
    NSLog(@"Se publica anuntul selectat");
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
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backToStatistics)];
    swipeLeft.numberOfTouchesRequired=1;
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.headerView addGestureRecognizer:swipeLeft]; 
    [swipeLeft release];
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
-(void) dealloc
{
    [tableAds release];
    [headerView release];
    [super dealloc];

}

@end
