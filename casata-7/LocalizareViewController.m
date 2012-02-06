//
//  LocalizareViewController.m
//  casata
//
//  Created by me on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalizareViewController.h"

@implementation LocalizareViewController
@synthesize mapView=_mapView;
@synthesize tempAd;
@synthesize dropPin;
@synthesize delegate, geocoder, locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Locatie"];
        
        //setam butonul din dreapta navBar-ului -adauga imaginile la anunt
        self.navigationItem.rightBarButtonItem =  [[[UIBarButtonItem alloc] initWithTitle:@"Salveaza" style:UIBarButtonItemStylePlain target:self action:@selector(selLocatieNoua)]autorelease]; 
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
        
        
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

-(void) dealloc
{   [dropPin release];///
    [tempAd release];
    [mapView release];
    [locationManager release];
    [super dealloc];
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
    UILongPressGestureRecognizer *longPressGesture=[[UILongPressGestureRecognizer alloc] initWithTarget: self action: @selector(handleLongPressGesture:)];
    [self.mapView addGestureRecognizer:longPressGesture];
    [longPressGesture release];
    dropPin=[TLocation alloc];
    
    if(tempAd.adlocation==nil)
   { NSLog(@"NU ARE LOCATIE");
       [self.navigationItem.rightBarButtonItem setEnabled:NO];
       flag=0;
   }
    else
    {   flag=1;
        NSLog(@"ARE DEJA LOCATIE"); 
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        [self.mapView addAnnotation:tempAd.adlocation];
        
        /*
        CLLocationCoordinate2D co = CLLocationCoordinate2DMake(44, 26);///++
        [dropPin initWithTitle:@"miau" andSubtitle:@"miau" andCoord:co];///+++
        [self.mapView addAnnotation:dropPin];//+++
         */
    }
    
    if (!self.locationManager) 
    {
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        self.locationManager.headingFilter = kCLHeadingFilterNone;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    }
    self.locationManager.delegate = self; 
    [locationManager startUpdatingLocation];
    
}

-(void) handleLongPressGesture: ( UIGestureRecognizer*)sender {
    
    NSLog(@"in gesture");
    
    NSNumber *lat=[NSNumber alloc];
    NSNumber *longit=[NSNumber alloc];
    NSString *name1=[NSString alloc];
    NSString *name2=[NSString alloc];
    name1=@"locatie noua";
    name2=@"locatie noua";
    
    if((sender.state==UIGestureRecognizerStateEnded)||(sender.state==UIGestureRecognizerStateChanged))
       { //[self.mapView removeGestureRecognizer:sender];
        NSLog(@"if gesutre");
        return;
       }
    else
    {   
        CGPoint point=[sender locationInView:self.mapView];
        CLLocationCoordinate2D locCoord = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        CLLocationCoordinate2D pinCoord;
        
        if(flag==1)
        {flag=0;
            [self.mapView removeAnnotation:tempAd.adlocation];
        }
        
        
        if((lat!=nil)&&(longit!=nil))
        {
            NSLog(@"remove ann");
            
            [self.mapView removeAnnotation:dropPin];
             
            //TLocation *dropPin= [TLocation alloc];
            
        }
        
        lat=[NSNumber numberWithDouble:locCoord.latitude];
        longit=[ NSNumber numberWithDouble:locCoord.longitude];
        
        pinCoord.latitude=lat.doubleValue;
        pinCoord.longitude=longit.doubleValue;
               
        [dropPin initWithTitle:name1 andSubtitle:name2 andCoord:pinCoord];
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
        
        NSLog(@"latitudine: @%f longitudine:@%f", lat.doubleValue,longit.doubleValue);
        [self.mapView addAnnotation:dropPin];
                                 
    }
}

-(void) selLocatieNoua 
{

    tempAd.adlocation = dropPin;
    NSLog(@"salveaza");
    [delegate performSelector:geocoder];
    //[self reverseGeocoding:dropPin];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    _mapView = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    CLLocationCoordinate2D zoomLocation;
    //zoomLocation.latitude=44.4;
    //zoomLocation.longitude=26.1;
    
    if(flag==0)//nu avem o locatie=>locatie curenta
    {
    zoomLocation.latitude = self.locationManager.location.coordinate.latitude;
    zoomLocation.longitude = self.locationManager.location.coordinate.longitude;
    }
    else //avem locatie=>zona vizibila este zona in care se afla anuntul
    {
    zoomLocation.latitude = tempAd.adlocation.coordinate.latitude;
    zoomLocation.longitude = tempAd.adlocation.coordinate.longitude;

    }    
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation,50000,50000);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end