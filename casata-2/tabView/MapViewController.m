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
#import "OptiuniHartaViewController.h"
#import "DetaliiAnuntViewController.h"
#import "TRequest.h"
#import "TAd.h"


//#define myURL [NSURL URLWithString:@"http://flapptest.comule.com/get_ads/"]


@implementation MapViewController
@synthesize mapView=_mapView;
@synthesize mapNavItem;
@synthesize searchBar;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Harta", @"Harta");
        self.tabBarItem.image = [UIImage imageNamed:@"mapicon"];
        //self.navigationItem = mapNavItem;
        
        
        
        //[self setTitle:@"Bucuresti"];
        
        
        
        
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(goHome)]autorelease];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"homepage.png"];
        
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Filtre" style:UIBarButtonItemStylePlain target:self action:@selector(selectOptiuni)]autorelease];   
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"rotita.png"];
        
        
        //butonul care va aparea ca back button pt view-ul child care va fi pus in stiva peste view-ul curent
        UIBarButtonItem *anuleazaButton = [[UIBarButtonItem alloc] initWithTitle:@"Inapoi" style:UIBarButtonItemStylePlain target:nil action:nil]; 
        
        anuleazaButton.tintColor = [UIColor blackColor];
        
        self.navigationItem.backBarButtonItem= anuleazaButton;  
        hasLoadView = 0;
        apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        
    }
    
    
    return self;
    
}
-(void) selectOptiuni
{
    OptiuniHartaViewController *optionsViewController = [[[OptiuniHartaViewController alloc] initWithNibName:@"OptiuniHartaViewController" bundle:nil]autorelease];
    
    //filtreViewController.hidesBottomBarWhenPushed = YES;
    
    
    [self.navigationController pushViewController:optionsViewController animated:YES];
}

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


-(void)goHome
{//AppDelegate *apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [apdelegate goToHomeScreen];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate=self;
    
    
    /////searchBar
    searchBar.tintColor = [UIColor colorWithRed:0.976 green:0.827 blue:0.015 alpha:1.0];
    
    self.navigationItem.titleView =searchBar;
    
    
    
    
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
    [searchBar release];
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
    
    [self getParamForReq];
    
    
    hasLoadView = 1;
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) getParamForReq{
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
    mapRequest = [TRequest alloc] ;
    [mapRequest initWithHost:@"http://flapptest.comule.com"];
    NSString *postString = [NSString stringWithFormat:@"left=%f&sessionTime=1325693857685&right=%f&bottom=%f&top=%f&currency=euro&request=get_ads&zoom=5000&sid=session1",left,right,bottom,top];
    NSLog(@"%@",postString);
    NSData * data;
    if([mapRequest makeRequestWithString:postString]!=0){
        data=[mapRequest requestData];
        [self showAdsFromData:data];
    }
    else NSLog(@"my req?");
    //TODO: get_more_ads;
    
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
        [anAd release];
        
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
        annotation.locationId = ad_id.intValue; NSLog(@"idul %d",annotation.locationId);
        [_mapView addAnnotation:annotation]; 
        [annotation release];        
        //Test Ad
        
        /*      TAd *anAd = [TAd alloc];
         [anAd TAd:row];
         NSLog(@"oras:%@", [anAd.ad objectForKey:@"oras"]);
         [anAd release];
         */
        //
    }
    NSNumber *found = [json objectForKey:@"ads_found"];
    NSLog(@" ADS FOUND %d",found.intValue);
}

-(void)detaliiAnunt:(id)sender
{
    UIButton *senderButton = (UIButton*)sender;
    NSLog(@"id anunt selectat este: %d",senderButton.tag);
    
    // aax =[apdelegate.appSession.globalAdList getAdAtIndex:0];
    // NSLog(@"add%@", [aax.ad objectForKey:@"oras"]);   
    
    DetaliiAnuntViewController *detaliiAnuntViewController = [[[DetaliiAnuntViewController alloc] initWithNibName:@"DetaliiAnuntViewController" bundle:nil]autorelease];
    
    detaliiAnuntViewController.ad_id = senderButton.tag;
    
    
    [self.navigationController pushViewController:detaliiAnuntViewController animated:YES];    
    
    
    /// 
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    NSLog(@"in annotation method");
    static NSString *identifier = @"MyLocation";   
    if ([annotation isKindOfClass:[TLocation class]]) {
        // MyLocation *location = (MyLocation *) annotation;
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        annotationView.image = [UIImage imageNamed:@"bluehouse"];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.image = [UIImage imageNamed:@"bluehouse"];
            
        } else {
            annotationView.annotation = annotation;
        }
        
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
        
        // [imgView release];
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        
        return annotationView;
    }
    NSLog(@"annotaion error");
    return nil;
}

-(void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    mapRequest = nil;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"drag");
    if(hasLoadView==1){
        [self getParamForReq];
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
    [super dealloc];
}
@end
