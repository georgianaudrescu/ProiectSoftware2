//
//  FirstViewController.m
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "MyLocation.h"

#define myURL [NSURL URLWithString:@"http://flapptest.comule.com/get_ads/"]


@implementation MapViewController
@synthesize mapView=_mapView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Map", @"Map");
        self.tabBarItem.image = [UIImage imageNamed:@"mapicon"];

    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //[super viewDidLoad];
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
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude=44.4;
    zoomLocation.longitude=26.1;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation,50000,50000);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    NSData *data = [NSData dataWithContentsOfURL:myURL];
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
        NSNumber * latitude = [ row objectForKey:@"lat"];
        NSNumber * longitude = [row objectForKey:@"long"];
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
    [super dealloc];
}
@end
