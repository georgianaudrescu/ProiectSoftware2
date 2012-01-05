//
//  FirstViewController.m
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "MyLocation.h"
#import "AppDelegate.h"
#import "OptiuniHartaViewController.h"
#import "TRequest.h"

#define myURL [NSURL URLWithString:@"http://flapptest.comule.com/get_ads/"]


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
{AppDelegate *apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
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
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude=44.4;
    zoomLocation.longitude=26.1;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation,50000,50000);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    
 /*
    //declararea request-ului
    NSURL *aUrl = [NSURL URLWithString:@"http://flapptest.comule.com"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
   
    //setarea requestului si a stringului pt POST
    [request setHTTPMethod:@"POST"];
    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *postString = @"left=25%2E96&sessionTime=1325693857685&right=26%2E24&bottom=44%2E33&top=44%2E53&currency=euro&request=get%5Fads&zoom=5000&sid=session1";
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLResponse *response;
    
    //primirea raspunsului 
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    // NSString *stringRespone = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // NSLog(@"response: %@", stringRespone);    
        
   // NSData *data = [NSData dataWithContentsOfURL:myURL];
*/
    TRequest * myRequest = [TRequest alloc] ;
    [myRequest initWithHost:@"http://flapptest.comule.com"];
    NSString *postString = @"left=25%2E96&sessionTime=1325693857685&right=26%2E24&bottom=44%2E33&top=44%2E53&currency=euro&request=get%5Fads&zoom=5000&sid=session1";
    NSData * data;
    if([myRequest makeRequestWithString:postString]!=0){
        data=[myRequest requestData];
    }
    
    if ([data length]==0)
    {
        [data release];
        NSLog(@"No data recieved from the server!");
        return;
    }
    NSLog(@"data fetched from server %@",data);
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *arr =[string componentsSeparatedByString:@"<!--"];
    NSLog(@"Array %@:",[arr objectAtIndex:0]);
    data=[[arr objectAtIndex:0] dataUsingEncoding: [NSString defaultCStringEncoding] ];

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
        
///DE MODIFICAT INAPOI DUPA CE SE CORECTEAZA PE SERVER -este inversata lat cu long
        //////////////////////////////////////////////////
        NSNumber * latitude = [ row objectForKey:@"long"];
        NSNumber * longitude = [row objectForKey:@"lat"];
        /////////////////////////////////////////////////
        
        NSString * name = [row objectForKey:@"name"];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude.doubleValue;
        coordinate.longitude = longitude.doubleValue; 
        MyLocation *annotation = [[MyLocation alloc]  initWithTitle:name andSubtitle:name];
        annotation.coordinate = coordinate;
        
        [_mapView addAnnotation:annotation]; 
        [annotation release];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    static NSString *identifier = @"MyLocation";   
    if ([annotation isKindOfClass:[MyLocation class]]) {
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


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [_mapView release];
    [mapView release];
    [mapNavItem release];
    [super dealloc];
}
@end
