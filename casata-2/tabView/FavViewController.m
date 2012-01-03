//
//  FavViewController.m
//  casata
//
//  Created by me on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FavViewController.h"
#import "AppDelegate.h"
#import "Informatii.h"


@implementation FavViewController

@synthesize favoritAles, segmentedControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Favorite", @"Favorite");
        self.tabBarItem.image = [UIImage imageNamed:@"star"];
        
        //setarea butoanelor din navbar
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(goHome)]autorelease];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"homepage.png"];
        
        // segmented control as the custom title view
        NSArray *segmentTextContent = [NSArray arrayWithObjects:
                                       NSLocalizedString(@"Anunturi", @""),
                                       NSLocalizedString(@"Locatii", @""),
                                       NSLocalizedString(@"Cautari", @""),
                                       nil];
        UISegmentedControl *segmentedControl2 = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
        
        segmentedControl = segmentedControl2;
         
        
        
        ///
        segmentedControl.selectedSegmentIndex = 0;
        
        
        
        ////
        segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        segmentedControl.frame = CGRectMake(0, 0, 400, 30.0);
        [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        
        
        segmentedControl.tintColor = [UIColor darkGrayColor];
        
        self.navigationItem.titleView = segmentedControl;
        
        [segmentedControl2 release];            
          
        
        
        
    }
    return self;
}
-(void)goHome
{AppDelegate *apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [apdelegate goToHomeScreen];
}

-(IBAction)segmentAction:(id)sender
{   //se afiseaza in NSLog indexul butonului selectat din meniul de sus
    
   // UISegmentedControl *segmentedControlSender = (UISegmentedControl *)sender;
	NSLog(@"Segment clicked: %d", segmentedControl.selectedSegmentIndex);  
    if(segmentedControl.selectedSegmentIndex == 0)
        favoritAles.text = @"Anunturi";
    else if(segmentedControl.selectedSegmentIndex == 1)
        favoritAles.text = @"Locatii";
    else if(segmentedControl.selectedSegmentIndex == 2)
        favoritAles.text = @"Cautari";
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)checkForSelectedFavFromHomePage
{
    NSLog(@"check----------");
    
    
    if([[Informatii selectedFavorite] isEqualToString:@"Anunturi"])
    {segmentedControl.selectedSegmentIndex=0;
        favoritAles.text=@"Anunturi";}
    
    else if ([[Informatii selectedFavorite] isEqualToString:@"Cautari"])
    {segmentedControl.selectedSegmentIndex=2;
        favoritAles.text=@"Cautari";}
    
    [Informatii selectedFavoriteChange:@""];    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    // Do any additional setup after loading the view from its nib. 
    
    [super viewDidLoad];
    favoritAles.text = @"Anunturi";  //cazul default
    
       
    //verifica daca cumva s-a facut deja selectia inainte de a se adauga la NotificationCenter
    if([[Informatii selectedFavorite] isEqualToString:@"Anunturi"])
    {segmentedControl.selectedSegmentIndex=0;
        favoritAles.text=@"Anunturi";
    }
    
    else if ([[Informatii selectedFavorite] isEqualToString:@"Cautari"])
    {segmentedControl.selectedSegmentIndex=2;
        favoritAles.text=@"Cautari";}
    
    [Informatii selectedFavoriteChange:@""];   
    
    
    //se adauga ca observator la Notificationcenter, in cazul in care se alege din home page una din tipurile de pagini "Favorite", se apeleaza o functie care selecteaza din meniul de sus butonul corespunzator
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkForSelectedFavFromHomePage) name:[Informatii selectFavNotificationName] object:nil];        
    
}
-(void)dealloc
{
    [favoritAles release];
    [segmentedControl release];
    [super dealloc];
}
     


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) viewDidAppear:(BOOL)animated
{
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
