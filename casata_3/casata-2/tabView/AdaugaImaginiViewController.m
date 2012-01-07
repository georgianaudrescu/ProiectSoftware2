//
//  AdaugaImaginiViewController.m
//  casata
//
//  Created by me on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AdaugaImaginiViewController.h"
#import "TImage.h" //just for test
#import "TFav.h"//just for test
#import "AppDelegate.h"//just for test
#import "TImage.h"
#import "TImageList.h"

@implementation AdaugaImaginiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

//TESTS   
  /* *******TLocationList Test********
   //
   TLocationList * myList = [[TLocationList alloc] init];
   CLLocationCoordinate2D testCoor;
   testCoor.latitude = 26.66;
   testCoor.longitude = 44.333;
   TLocation * testLoc = [[TLocation alloc] initWithTitle:@"nume" andSubtitle:@"subtitle" andCoord:testCoor];
   NSLog(@"name1 %@",testLoc.title);
   [myList addLocation:testLoc];
   TLocation * newLoc = [myList getLocationFromIndex:0];
   NSString * aString = newLoc.title;
   NSLog(@"name %@", aString);
   NSLog(@"index %d",[myList getIndexForLocation:testLoc] );
   NSLog(@"count:%d", myList.count);
   [myList removeLocation:testLoc];
   NSLog(@"count:%d", myList.count);
   
   [myList release];
   [newLoc release];
   //end Location Test***** */
  
    
    
    /*  
   //TImage test  
    TImage *anImage = [TImage alloc];
    anImage.imageId=1;
    anImage.description=@"etc";
   
   //initializare cu ajutorul unui url
    [anImage initWithImageFromUrlString:@"http://www.incasa.ro/_files/Image/galerie/5/casa_1.jpg"];
   
   //initializarea imageView-ului cu un UIImage(folositor pt image upload, unde pickerul returneaza un UIImage)
   //[anImage initWithImage:[UIImage imageNamed:@"house.jpg"]]; 
    //anImage.imageView.frame = CGRectMake(0, 0, 30, 30);
    [self.view addSubview:anImage.imageView];
     TImageList *imgList = [[TImageList alloc]init];
    
    [imgList addImage:anImage];
    
    
    TImage *test = [imgList getImageAtIndex:0];
    
    NSLog(@"desc of imag %@", test.description);
    
    NSLog(@"index:%d", [imgList getIndexForImage:anImage]);
    NSLog(@"count:%d", imgList.count);
    [imgList removeImage:anImage];
    NSLog(@"count:%d", imgList.count);
   
     
    [anImage release];
    [imgList release];
    
    */
   
    
 
    /*
     //testare TFav
    TFav *favorite = [[TFav alloc]init];
    NSString *string = [[NSString alloc] initWithString:@"A string"];
    [favorite.favAdsList addObject:string];
    [string release];
    NSLog(@"%@",[favorite.favAdsList objectAtIndex:0]);
    [favorite release];
   */
    
   /*
     //globalvariablestest
     AppDelegate *apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *aString = [[NSString alloc] initWithString:@"AAAaaaaaaaaSTRING"];
    [apdelegate.appSession.globalAdList addObject:aString];
    [aString release];
    NSLog(@"%@",[apdelegate.appSession.globalAdList objectAtIndex:0]);
    NSString *lati = [[NSString alloc]initWithString:@"44.44"];
    NSString *longi = [[NSString alloc]initWithString:@"22.22"];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = lati.doubleValue;
    coordinate.longitude = longi.doubleValue; 
    apdelegate.appSession.currentLocation.coordinate=coordinate;
    [lati release];
    [longi release];
    
    NSString *aaa = [[NSString alloc] initWithFormat:@"%f",  apdelegate.appSession.currentLocation.coordinate];
    NSLog(@"coord:%@",aaa);
    [aaa release];
    */
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