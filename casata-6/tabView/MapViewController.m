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
        onlyFavAdsVisible=NO;
        
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
    flag_get_more_ads=0;
   
        threadRequest = [[NSThread alloc] initWithTarget:self selector:@selector(getParamForReq) object:nil];
    //[lock  lockWhenCondition:0];
    [threadRequest start];
    
    [super viewDidLoad];
    //self.mapView.delegate=self;
    
    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"starfav.png"];
    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"starfavDeactivat.png"];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"plus.png"];
    
      
    self.detaliiAnuntViewController =[[DetaliiAnuntViewController alloc] initWithNibName:@"DetaliiAnuntViewController" bundle:nil];
    self.detaliiAnuntViewController.delegate=self;//
    self.detaliiAnuntViewController.hidePinIfRemovedFromFav= @selector(hidePinWhenFavesVisibleAndCurrentAdRemovedFromFav);//
    
                                 
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
   
    //filtru
     filtru = self.statisticsView.filters;
    filtru.flag_filtre = 0;
    filtru.filters_exist = 0;

    
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
    //zoomLocation.latitude=44.4;
    //zoomLocation.longitude=26.1;
    zoomLocation.longitude = apdelegate.locationManager.location.coordinate.longitude;
    zoomLocation.latitude = apdelegate.locationManager.location.coordinate.latitude;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation,50000,50000);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    _mapView.showsUserLocation=YES;
    
   // [self getParamForReq];
    flag=1;
    flag_get_more_ads=1;
    
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
        while (flag==0 && filtru.flag_filtre == 0) {
            [NSThread sleepForTimeInterval:0.005];
        }
        if(flag != 0)
        {
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
    NSMutableString *postString = [NSMutableString stringWithFormat:@"left=%f&sessionTime=1325693857685&right=%f&bottom=%f&top=%f&currency=euro&request=get_ads&zoom=5000&sid=session1",left,right,bottom,top];
            
            if (filtru.filters_exist)
            {
                //apply additional parameters
                //take filters
                NSMutableDictionary *fil = [filtru applyFilters];
                //add filters to string
                NSMutableString *ad_type = [fil objectForKey: @"types"];
                if(ad_type != nil)
                {
                    if([ad_type isEqualToString:@"Vanzare"])
                        ad_type = [NSMutableString stringWithString:@"sale"];
                    else if([ad_type isEqualToString:@"Inchiriere"]) 
                        ad_type = [NSMutableString stringWithString:@"rent"];
                    
                    [postString appendString:[NSMutableString stringWithFormat:@"&ad_type=%@", ad_type]]; 
                }
                /*        [self ProcessRequest:fil atString:postString withfiltru:@"propertyy" andparam:@"&property_type=%@"];*/
                [self ProcessRequest:fil atString:postString withfiltru:@"smin" andparam:@"&size_min=%@"];
                [self ProcessRequest:fil atString:postString withfiltru:@"smax" andparam:@"&size_max=%@"];
                [self ProcessRequest:fil atString:postString withfiltru:@"pmin" andparam:@"&p_min=%@"];
                [self ProcessRequest:fil atString:postString withfiltru:@"pmax" andparam:@"&p_max=%@"];
                
                NSLog(@"in thread GetAds with filter postString: %@", postString);
            }
    
    if(flag==1) continue;
    mapRequest = [TRequest alloc] ;
    [mapRequest initWithHost:@"http://flapptest.comule.com"];
    
    NSData * data;
    if([mapRequest makeRequestWithString:postString]!=0){
        data=[mapRequest requestData];
        
        [self showAdsFromData:data];
        flag_get_more_ads=1;
        
    }
    [mapRequest release];
    
    postString = [NSString stringWithFormat:@"sessionTime=1327150364534&request=get_more_ads&sid=session1"];    
    while (flag_get_more_ads==1)
    {
        postString = [NSString stringWithFormat:@"sessionTime=1327150364534&request=get_more_ads&sid=session1"];
        [self getMoreAds:postString];
    }
            
    //[lock unlockWithCondition:0];
            flag=0;
        }
        
        if(filtru.flag_filtre != 0)
        {
            NSLog(@"thread filtre");
            filtru.flag_filtre = 0;
            //take coord for request
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
            //string for request
            NSMutableString *postString = [NSMutableString stringWithFormat:@"left=%f&sessionTime=1325693857685&right=%f&bottom=%f&top=%f&currency=euro&request=get_ads&zoom=5000&sid=session1",left,right,bottom,top];
            //take filters
            NSMutableDictionary *fil = [filtru applyFilters];
            //add filters to string
            NSMutableString *ad_type = [fil objectForKey: @"types"];
            if(ad_type != nil)
            {
                if([ad_type isEqualToString:@"Vanzare"])
                    ad_type = [NSMutableString stringWithString:@"sale"];
            else if([ad_type isEqualToString:@"Inchiriere"]) 
                ad_type = [NSMutableString stringWithString:@"rent"];
                
            [postString appendString:[NSMutableString stringWithFormat:@"&ad_type=%@", ad_type]]; 
            }
    /*        [self ProcessRequest:fil atString:postString withfiltru:@"propertyy" andparam:@"&property_type=%@"];*/
            [self ProcessRequest:fil atString:postString withfiltru:@"smin" andparam:@"&size_min=%@"];
             [self ProcessRequest:fil atString:postString withfiltru:@"smax" andparam:@"&size_max=%@"];
             [self ProcessRequest:fil atString:postString withfiltru:@"pmin" andparam:@"&p_min=%@"];
             [self ProcessRequest:fil atString:postString withfiltru:@"pmax" andparam:@"&p_max=%@"];
            NSLog(@"In filtre thread post string: %@", postString);
            TRequest *mapRequestFiltru = [TRequest alloc] ;
            [mapRequestFiltru initWithHost:@"http://flapptest.comule.com"];
            
            filtru.filters_exist = 1;
            
            NSData * data;
            if([mapRequestFiltru makeRequestWithString:postString]!=0){
                data=[mapRequestFiltru requestData];
                
                [self showAdsFromData:data];
            }
        }
    }
    
    [pool release];
}

-(void) ProcessRequest:(NSMutableDictionary *)filtre2 
              atString:(NSMutableString *) postString 
            withfiltru: (NSString *) filtruz andparam:(NSString *) param
{
    if([filtre2 objectForKey:filtruz] != nil)
    {
        NSMutableString *ceva = [filtre2 objectForKey:filtruz];
        [postString appendString:[NSMutableString stringWithFormat:param,ceva]]; 
    }
}

-(void) getMoreAds: (NSString *) postString
{
    
    NSLog(@"GET MORE ADS");
    NSData * get_more_ads_data;
    TRequest *moreAdsRequest = [TRequest alloc] ;
    [moreAdsRequest initWithHost:@"http://flapptest.comule.com"];
    
    if([moreAdsRequest makeRequestWithString:postString]!=0)
    {
        get_more_ads_data=[[moreAdsRequest requestData] retain];
        NSString *string = [[NSString alloc] initWithData:get_more_ads_data encoding:NSUTF8StringEncoding];
        //NSLog(@"All the data received in NSString format: %@",string );
        NSLog(@"GET MORE ADS string : %@",string);
        //NSNumber * ads_per_pack = [moreAdsRequest getAdsPerPack]; 
        
        NSError* error;
        NSDictionary* json2 = [NSJSONSerialization 
                               JSONObjectWithData:get_more_ads_data 
                               options:kNilOptions 
                               error:&error];
        NSLog(@"data JSON from: %@", json2); 
        //nr = [json objectForKey:@"ads_per_pack"];
        NSNumber * ads_per_pack = [json2 objectForKey:@"new_ads_sent"];
        if (ads_per_pack.integerValue ==0) 
        {
            flag_get_more_ads=0;
            //return;
        }
        else{
            
            [self showAdsFromData:get_more_ads_data];
            
        }
    }
    [moreAdsRequest release];
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
    
    // Return nil for the user's locatio
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    
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
    { if(apdelegate.appSession.favorites.count !=0)//daca avem favorite in lista
    {
        onlyFavAdsVisible=YES;
        NSLog(@"Show fav ads on map");
        self.navigationItem.rightBarButtonItem.tag=1;
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"starfav.png"];
        
        //deselectam pinul curent selectat(poate nu este in favorite)
        [self.mapView deselectAnnotation:selectedAnnotation animated:NO];
        
        //in cazul in care scrollul este dat in jos(nu mai este vizibila harta) si se apasa pe butonul de fav, mutam scolul automat pentru a se vedea harta-putem sa schimbam daca nu este nevoie de asta
        [self.scrollView setContentOffset: CGPointMake(0, 0) animated:YES];
        
        //ascundem anunturile care nu sunt favorite
        int totalFav=apdelegate.appSession.favorites.count;
        int totalAds=apdelegate.appSession.globalAdList.count;
        int isFav;
        for(int j=0;j<totalAds;j++)
        {    TAd *gAd = [apdelegate.appSession.globalAdList getAdAtIndex:j];
            isFav=0;
            for(int i=0; i<totalFav;i++)
            {   
                TAd *tempAd = [apdelegate.appSession.favorites getAdAtIndex:i];
                if(gAd == tempAd)
                {isFav=1;}
                tempAd=nil;
            } 
            if(isFav==0) { [[self.mapView viewForAnnotation:gAd.adlocation] setHidden:YES];}
            gAd=nil;
        }  
    }
    else //daca nu avem favorite, afisam un mesaj corespunzator
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Nu ai anunturi favorite." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }        
        
        
        
    }
    else 
    {   onlyFavAdsVisible=NO;
        NSLog(@"Show all ads on map/deselect fav button");
        self.navigationItem.rightBarButtonItem.tag=0;
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"starfavDeactivat.png"];
        
        //deselectat pinul curent selectat
        [self.mapView deselectAnnotation:selectedAnnotation animated:NO];
        
        //in cazul in care scrollul este dat in jos(nu mai este vizibila harta) si se apasa pe butonul de fav, mutam scolul automat pentru a se vedea harta-putem sa schimbam daca nu este nevoie de asta
        [self.scrollView setContentOffset: CGPointMake(0, 0) animated:YES];
        
        //facem vizibile toate pinurile
        int totalAds = apdelegate.appSession.globalAdList.count;
        for(int j=0;j<totalAds;j++)
        {    TAd *gAd = [apdelegate.appSession.globalAdList getAdAtIndex:j];
            [[self.mapView viewForAnnotation:gAd.adlocation]setHidden:NO];
            gAd=nil;
        }
    }
    
}

-(void) hidePinWhenFavesVisibleAndCurrentAdRemovedFromFav
{

    if(onlyFavAdsVisible==YES)
    {
 [self.mapView deselectAnnotation:selectedAnnotation animated:NO];
        [[self.mapView viewForAnnotation:selectedAnnotation] setHidden:YES];
    
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
        flag_get_more_ads=0;
        
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
