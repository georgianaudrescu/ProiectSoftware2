//
//  FirstViewController.m
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "TLocation.h"
#import "AppDelegate.h"

#import "DetaliiAnuntViewController.h"
#import "TRequest.h"
#import "TAd.h"
#import "TAnnotationView.h"

#import "Filtre.h" // for the switch
#import "SomeView.h" //for switch test!
#import "StatsViewController.h"

//#define myURL [NSURL URLWithString:@"http://flapptest.comule.com/get_ads/"]


@implementation MapViewController
@synthesize mapView=_mapView;
@synthesize mapNavItem;

@synthesize touchView, selectedAnnotation;
@synthesize statisticsView,detaliiAnuntViewController;
@synthesize scrollView,subScroll;

NSString * const GMAP_ANNOTATION_SELECTED = @"gmapselected";


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Harta", @"Harta");
      
        
        //punem logo-ul in view-ul pt tilu al navBar-lui
        UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logosmall.png"]];
                self.navigationItem.titleView = logoImageView;
        [logoImageView release];
        
        
        //setam butonul din stanga navBar-ului -adauga anunt
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(goToAdaugaAnunt)]autorelease];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"plus.png"];
        
        //setam butonul din dreapta navBar-ului -favorite pe harta
        self.navigationItem.rightBarButtonItem =  [[[UIBarButtonItem alloc] initWithTitle:@"Fav" style:UIBarButtonItemStylePlain target:self action:@selector(showFavAdsOnMap)]autorelease]; 
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
        
        //initial nu este selectat sa se arate anunturile favorite pe ecran
        self.navigationItem.rightBarButtonItem.tag=0;
        
         self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"starfav.png"];
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"starfavDeactivat.png"];
        
        
        //butonul care va aparea ca back button pt view-ul child care va fi pus in stiva peste view-ul curent
        UIBarButtonItem *anuleazaButton = [[UIBarButtonItem alloc] initWithTitle:@"Inapoi" style:UIBarButtonItemStylePlain target:nil action:nil]; 
        
        anuleazaButton.tintColor = [UIColor blackColor];
        
        self.navigationItem.backBarButtonItem= anuleazaButton;  
        
        
        hasLoadView = 0;
        
        apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        
    }
    
    
    return self;
    
}


//Schimba culoarea textului din titleView (prin default textul este alb)
//metoda poate fi stearsa daca ramanem cu logo in locul titlului
-(void)setTitle:(NSString *)title
{
    [super setTitle:@"Harta"];
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
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    //lock = [[NSConditionLock alloc] initWithCondition:0];
    flag=0;
    threadRequest = [[NSThread alloc] initWithTarget:self selector:@selector(getParamForReq) object:nil];
    //[lock  lockWhenCondition:0];
    [threadRequest start];
    
    [super viewDidLoad];
    //self.mapView.delegate=self;
    
    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"starfav.png"];
    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"starfavDeactivat.png"];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"plus.png"];
    
      
    self.detaliiAnuntViewController =[[DetaliiAnuntViewController alloc] initWithNibName:@"DetaliiAnuntViewController" bundle:nil];
                                 
    touchView = [[TTouchView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	touchView.delegate = self;
	touchView.callAtHitTest = @selector(stopFollowLocation); 
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	self.mapView.delegate = self;
    [touchView addSubview:self.mapView];    
    [self.scrollView addSubview:touchView];
    
   	
    self.statisticsView = [[StatsViewController alloc] initWithNibName:@"StatsViewController" bundle:nil];
    self.statisticsView.view.frame = CGRectMake(0, 366,self.statisticsView.view.frame.size.width, self.statisticsView.view.frame.size.height);
    [self.scrollView addSubview:self.statisticsView.view];
   
    
    /*
    self.subScroll.frame = CGRectMake(0,300, self.subScroll.frame.size.width, self.subScroll.frame.size.height);
    self.subScroll.pagingEnabled = YES;
    self.subScroll.bounces=NO;
    self.scrollView.bounces=NO;
    [self.subScroll setContentSize:CGSizeMake(960, 260)];
    [self.scrollView addSubview:self.subScroll];
    */
    
    [self.scrollView setContentSize:CGSizeMake(320, 782)];

	
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)addAction:(id)sender
{
	// The add button was clicked, handle it here
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [_mapView release];
    _mapView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    // AppDelegate *apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude=44.4;
    zoomLocation.longitude=26.1;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation,50000,50000);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    
   // [self getParamForReq];
    flag=1;
    
    
    hasLoadView = 1;
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) getParamForReq{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    
    while (TRUE) {
        NSLog(@"IN THREAD");
    //[lock lockWhenCondition:0];
        while (flag==0) {
            [NSThread sleepForTimeInterval:0.005];
        }
        flag=0;
    MKMapRect visibleRegion = _mapView.visibleMapRect;
    
    MKMapPoint cornerPointNE = MKMapPointMake(visibleRegion.origin.x + visibleRegion.size.width, visibleRegion.origin.y);
    CLLocationCoordinate2D cornerCoordinateNE = MKCoordinateForMapPoint(cornerPointNE);
    NSLog(@"%f",cornerCoordinateNE.latitude);
    MKMapPoint cornerPointSW = MKMapPointMake(visibleRegion.origin.x, visibleRegion.origin.y + visibleRegion.size.height);
    CLLocationCoordinate2D cornerCoordinateSW = MKCoordinateForMapPoint(cornerPointSW);
    top = cornerCoordinateNE.latitude;
    bottom = cornerCoordinateSW.latitude;
    left = cornerCoordinateSW.longitude;
    right = cornerCoordinateNE.longitude;
    NSLog(@"%f, %f, %f, %f",left,right,top,bottom);
    //TODO zoom level;
    
    ///
    ///request data
    ///
    NSString *postString = [NSString stringWithFormat:@"left=%f&sessionTime=1325693857685&right=%f&bottom=%f&top=%f&currency=euro&request=get_ads&zoom=5000&sid=session1",left,right,bottom,top];
    
    if(flag==1) continue;
    mapRequest = [TRequest alloc] ;
    [mapRequest initWithHost:@"http://flapptest.comule.com"];
    
    NSData * data;
    if([mapRequest makeRequestWithString:postString]!=0){
        data=[mapRequest requestData];
        
        [self showAdsFromData:data];
    }
    [mapRequest release];
    //[lock unlockWithCondition:0];
        flag=0;
    }
    
    [pool release];
}

-(void) showAdsFromData:(NSData *)data{
    if ([data length]==0)
    {
        [data release];
        NSLog(@"No data recieved from the server!");
        return;
    }
    NSLog(@"data fetched from server %@",data);
    
    
    self.view.hidden = NO;
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:data
                          options:kNilOptions 
                          error:&error];
    NSLog(@"data JSON: %@", json); 
    NSArray *allAds = [json objectForKey:@"ads"];
    
    for(NSDictionary *row in allAds)
    {
        // AppDelegate *apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        TAd *anAd = [TAd alloc];
        [anAd TAd:row];
        [apdelegate.appSession.globalAdList addAd:anAd];
        //[anAd release];
        
        NSNumber * latitude = [ row objectForKey:@"lat"];
        NSNumber * longitude = [row objectForKey:@"long"];        
        
        
        NSNumber *ad_id = [row objectForKey:@"id"];/////////
        NSString * name = [row objectForKey:@"name"];     
        NSString * subName = [row objectForKey:@"property_type"];
               
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude.doubleValue;
        coordinate.longitude = longitude.doubleValue; 
        TLocation *annotation = [[TLocation alloc]  initWithTitle:name andSubtitle:subName andCoord:coordinate];
        //annotation.coordinate = coordinate;
        annotation.locationId = ad_id.intValue; 
        anAd.adlocation=annotation;
        [annotation release];
        
        NSLog(@"idul %d",anAd.adlocation.locationId);
       
        
        [_mapView addAnnotation:anAd.adlocation]; 
        [anAd release];       
        
    }
    NSNumber *found = [json objectForKey:@"ads_found"];
    NSLog(@" ADS FOUND %d",found.intValue);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    NSLog(@"in annotation method");
    
    
    static NSString *identifier = @"TLocation";   
    if ([annotation isKindOfClass:[TLocation class]]) {
        // MyLocation *location = (MyLocation *) annotation;
        
        
        TAnnotationView *annotationView = (TAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        annotationView.image = [UIImage imageNamed:@"bluehouse"];
        if (annotationView == nil) {
            annotationView = [[TAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.image = [UIImage imageNamed:@"bluehouse"];
            
        } else {
            annotationView.annotation = annotation;
        }
        
        /* 
         UIImageView *imgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"house.jpg"]]autorelease];
         //////
         UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
         [rightButton addTarget:self
         action:@selector(detaliiAnunt:)
         forControlEvents:UIControlEventTouchUpInside];
         TLocation *loc = (TLocation*)annotation;
         rightButton.tag = loc.locationId;
         annotationView.rightCalloutAccessoryView=rightButton;
         //////                                                               
         imgView.frame =CGRectMake(0, 0, 30, 30);
         annotationView.leftCalloutAccessoryView = imgView;
         */ 
        // [imgView release];
        annotationView.enabled = YES;
        // annotationView.canShowCallout = YES;
        [annotationView addObserver:self
                         forKeyPath:@"selected"
                            options:NSKeyValueObservingOptionNew
                            context:GMAP_ANNOTATION_SELECTED];        
        
        return annotationView;
    }
    NSLog(@"annotaion error");
    return nil;
    
}
////////////////////
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
	
    NSString *action = (NSString*)context;
	
    if([action isEqualToString:GMAP_ANNOTATION_SELECTED]){
		BOOL annotationAppeared = [[change valueForKey:@"new"] boolValue];
		if (annotationAppeared) {
			NSLog(@"annotation selected %@", ((TAnnotationView*) object).annotation.title);
			[self showAnnotation:((TAnnotationView*) object).annotation];
			selectedAnnotation = ((TAnnotationView*) object).annotation;
			((TAnnotationView*) object).image = [UIImage imageNamed:@"redhouse.png"];
		}
		else {
            //annotation deselected
			NSLog(@"annotation deselected %@", ((TAnnotationView*) object).annotation.title);
            [self hideAnnotation];
            ((TAnnotationView*) object).image = [UIImage imageNamed:@"bluehouse.png"];
			//[self.detaliiAnuntViewController.view removeFromSuperview];
            [self hideAnnotation];
            
            // selectedAnnotation=nil;
            
			
		}
	}
}
- (void)showAnnotation:(TLocation*)annotation {
	
    //NSLog(@"showing annotation");
    
    
	[self.statisticsView.view addSubview:self.detaliiAnuntViewController.view];
    [self.detaliiAnuntViewController loadAdWithId:annotation.locationId];
    self.detaliiAnuntViewController.view.frame = CGRectMake(0,400, self.statisticsView.view.frame.size.width, self.statisticsView.view.frame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        self.detaliiAnuntViewController.view.frame = CGRectMake(0,0, self.statisticsView.view.frame.size.width, self.statisticsView.view.frame.size.height);}];

}

- (void) stopFollowLocation {
	
	[self.mapView deselectAnnotation:selectedAnnotation animated:NO];
	
	
	//[self hideAnnotation];
    
	
}

- (void)hideAnnotation {
    
    //self.detaliiAnuntViewController.view.frame = CGRectMake(0,0, self.statisticsView.view.frame.size.width, self.statisticsView.view.frame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        self.detaliiAnuntViewController.view.frame = CGRectMake(0,500, self.statisticsView.view.frame.size.width, self.statisticsView.view.frame.size.height);}];    

        
	/*    
	[UIView beginAnimations: @"moveCNGCalloutOff" context: nil];
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDuration: 0.5];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	self.customCalloutView.frame = CGRectMake(10.0, 250.0 + 300, self.customCalloutView.frame.size.width, self.customCalloutView.frame.size.height);
	[UIView commitAnimations];
     */
}


//afisam fie anunturile favorite, fie toate anunturile
-(void) showFavAdsOnMap
{
    if(self.navigationItem.rightBarButtonItem.tag == 0)
    { NSLog(@"Show fav ads on map");
      self.navigationItem.rightBarButtonItem.tag=1;
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"starfav.png"];

        //deselectam pinul curent selectat(poate nu este in favorite)
        [self.mapView deselectAnnotation:selectedAnnotation animated:NO];
        
        //in cazul in care scrollul este dat in jos(nu mai este vizibila harta) si se apasa pe butonul de fav, mutam scolul automat pentru a se vedea harta-putem sa schimbam daca nu este nevoie de asta
        [self.scrollView setContentOffset: CGPointMake(0, 0) animated:YES];
    }
    else 
    {NSLog(@"Show all ads on map/deselect fav button");
     self.navigationItem.rightBarButtonItem.tag=0;
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"starfavDeactivat.png"];
        
        //deselectat pinul curent selectat
    [self.mapView deselectAnnotation:selectedAnnotation animated:NO];
        
        //in cazul in care scrollul este dat in jos(nu mai este vizibila harta) si se apasa pe butonul de fav, mutam scolul automat pentru a se vedea harta-putem sa schimbam daca nu este nevoie de asta
        [self.scrollView setContentOffset: CGPointMake(0, 0) animated:YES];
    }
    
}

-(void)goToAdaugaAnunt{
    NSLog(@"Goto adauga anunt");
    
    //[self.view addSubview:someView.view]; 
    /*
    [self.navigationController pushViewController:someView animated:YES];
    someView.view.frame = CGRectMake(0,-400, self.view.frame.size.width, self.view.frame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        someView.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);}];
     */
    
    AdaugAnuntViewController * adaugAnuntView = [[[AdaugAnuntViewController alloc] initWithNibName:@"AdaugAnuntViewController" bundle:nil]autorelease];
    //[self.view addSubview:adaugAnuntView.view];
    [self.navigationController pushViewController:adaugAnuntView animated:YES];
     
}


/////////////////////
-(void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    mapRequest = nil;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"drag");
    if(hasLoadView==1){
        //[lock unlockWithCondition:1];
        flag=1;
        
        // get data for thread 
        //wake up thread
        //[self getParamForReq];
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    mapRequest = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    //mapRequest = nil;
    
    [_mapView release];
    [mapView release];
    [mapNavItem release];
    //////
    [selectedAnnotation release];
    [touchView release];
    [statisticsView release];
    [scrollView release];
    [subScroll release];
    //[adaugAnuntView release];
    
    [super dealloc];
}
@end
