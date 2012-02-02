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
#import "Reachability.h"

//#define myURL [NSURL URLWithString:@"http://flapptest.comule.com/get_ads/"]

#define MERCATOR_RADIUS 85445659.44705395


@implementation MapViewController
@synthesize mapView=_mapView;
@synthesize mapNavItem;

@synthesize touchView, selectedAnnotation;
@synthesize statisticsView,detaliiAnuntViewController;
@synthesize scrollView,subScroll;
@synthesize locationManager;
@synthesize internetActive;

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
        onlyFilteredAdsVisible=NO;
        
        if (!self.locationManager) 
        {
            self.locationManager = [[[CLLocationManager alloc] init] autorelease];
            self.locationManager.headingFilter = kCLHeadingFilterNone;
            self.locationManager.distanceFilter = kCLDistanceFilterNone;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        }
        self.locationManager.delegate = self; 
        [locationManager startUpdatingLocation];
        flag_user_location=0;
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
    
    
   
    threadRequest = [[NSThread alloc] initWithTarget:self selector:@selector(threadReqMethod) object:nil];
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
    
    ////resize detalii
    self.detaliiAnuntViewController.view.frame = CGRectMake(0, 0, 320, 464);//464
    
    
    
                                 
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
    self.statisticsView.filters.delegate=self;
    self.statisticsView.filters.seAplicaFiltre = @selector(seAplicaFiltrele);
    self.statisticsView.filters.seStergFiltre =@selector(seStergFiltrele);
    
   
    //my ads selected ad
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToEditAnunt:) name:@"AnuntPropriuSelectat" object:nil];     
   
    
    
    /*
    self.subScroll.frame = CGRectMake(0,300, self.subScroll.frame.size.width, self.subScroll.frame.size.height);
    self.subScroll.pagingEnabled = YES;
    self.subScroll.bounces=NO;
    self.scrollView.bounces=NO;
    [self.subScroll setContentSize:CGSizeMake(960, 260)];
    [self.scrollView addSubview:self.subScroll];
    */
    
    [self.scrollView setContentSize:CGSizeMake(320, 782)];
    [self.scrollView setPagingEnabled:YES]; 
	
    
    
    
    ////////adaug favoritele pe harta cand se deschide aplicatia
    NSLog(@"FAVORITELE %d",[apdelegate.appSession.user.favorites count]);
    if([apdelegate.appSession.user.favorites count]>0)
    { int nrFav=[apdelegate.appSession.user.favorites count];
        for(int x=0;x<nrFav;x++)
        { NSLog(@"ad favorite on map");
            TAd *tempAd = [apdelegate.appSession.user.favorites getAdAtIndex:x];
            
            [self.mapView addAnnotation:tempAd.adlocation];
            [apdelegate.appSession.globalAdList addAd:tempAd];
            tempAd=nil;
        }
    }
    ///////   
    
    // check for internet connection
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [[Reachability reachabilityForInternetConnection] retain];
    [internetReachable startNotifier];
    
    // check if a pathway to a random host exists
    hostReachable = [[Reachability reachabilityWithHostName: @"flapptest.comule.com"] retain];
    [hostReachable startNotifier];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    CLLocationCoordinate2D zoomLocation;
    //zoomLocation.latitude=44.4;
    //zoomLocation.longitude=26.1;
    zoomLocation.longitude =self.locationManager.location.coordinate.longitude;
    zoomLocation.latitude = self.locationManager.location.coordinate.latitude;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation,50000,50000);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    _mapView.showsUserLocation=YES;
    
    // [self getParamForReq];
    flag=1;
    flag_get_more_ads=1;
    
    hasLoadView = 1;
    

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

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if(flag_user_location == 0){
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.longitude =newLocation.coordinate.longitude;
    zoomLocation.latitude = newLocation.coordinate.latitude;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation,50000,50000);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    _mapView.showsUserLocation=YES;
    NSLog(@"NEW LOCATION");
        flag_user_location=1;
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    // AppDelegate *apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    /*
    CLLocationCoordinate2D zoomLocation;
    //zoomLocation.latitude=44.4;
    //zoomLocation.longitude=26.1;
    zoomLocation.longitude =self.locationManager.location.coordinate.longitude;
    zoomLocation.latitude = self.locationManager.location.coordinate.latitude;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation,50000,50000);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    _mapView.showsUserLocation=YES;
    
   // [self getParamForReq];
    flag=1;
    flag_get_more_ads=1;
    
    hasLoadView = 1;
    */
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void) getParamForReq{
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
    /*
    MKMapPoint estMapPoint = MKMapPointMake(MKMapRectGetMinX(visibleRegion),MKMapRectGetMidY(visibleRegion));
    MKMapPoint vestMapPoint = MKMapPointMake(MKMapRectGetMaxX(visibleRegion), MKMapRectGetMidY(visibleRegion));
    int currentDist = MKMetersBetweenMapPoints(estMapPoint, vestMapPoint);
    NSLog(@"_____ZOOM LEVEL____:%d", currentDist);
     */
    
}

- (void) threadReqMethod{
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    while (TRUE) {
        NSLog(@"IN THREAD");
    //[lock lockWhenCondition:0];
        while (flag==0) {
            [NSThread sleepForTimeInterval:0.005];
        }
        if(flag != 0)
        {
        flag=0;
       
    ///
    ///request data
    ///
            
    [self getParamForReq];
            
            ///////
          //  NSMutableString *idses = [NSMutableString stringWithString:@"sessionTime=1328057240360&request=close%5Fsession&sid="];
           // [idses appendString:self.appSession.user.userId];
           // NSString * postString=[NSString stringWithString:idses];

    
            
    NSMutableString *postString = [NSMutableString stringWithFormat:@"left=%f&sessionTime=1325693857685&right=%f&bottom=%f&top=%f&currency=euro&request=get_ads&zoom=5000&sid=",left,right,bottom,top];
            [postString appendString: apdelegate.appSession.user.userId];
     if(onlyFilteredAdsVisible==YES)
        {NSMutableString *filtreString = [apdelegate.appSession getStringForFilters];
        [postString appendString:filtreString];
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
    
    //[lock unlockWithCondition:0];
            flag=0;
     }
        
        NSMutableString * postString = [NSMutableString stringWithFormat:@"sessionTime=1327150364534&request=get_more_ads&sid="];   
        [postString appendString:apdelegate.appSession.user.userId];
        while ((flag_get_more_ads==1)&&(onlyFavAdsVisible==NO))
        {
            postString = [NSMutableString stringWithFormat:@"sessionTime=1327150364534&request=get_more_ads&sid="];
            [postString appendString:apdelegate.appSession.user.userId];
            [self getMoreAds:postString];
        }
         }
    
    [pool release];
}


-(void)seAplicaFiltrele
{ //ascundem pinurile care nu corespund
    onlyFilteredAdsVisible=YES;
    
    //mutam scolul automat pentru a se vedea harta-putem sa schimbam daca nu este nevoie de asta
    [self.scrollView setContentOffset: CGPointMake(0, 0) animated:YES];  
    
    NSMutableString *filtreString = [apdelegate.appSession getStringForFilters];
    NSLog(@"filtre request params: %@", filtreString);
    
    if(onlyFavAdsVisible==YES) //aplicam filtre pe lista de favorite
    {
        [self aplicareFiltrePeLista:apdelegate.appSession.user.favorites];
    
    }
    else
    {
        [self aplicareFiltrePeLista:apdelegate.appSession.globalAdList];        
         
    }

}

-(void)aplicareFiltrePeLista:(TAdList*)theList
{
    //afisam toate anunturile din Lista
    [self seStergFiltrele];
    onlyFilteredAdsVisible=YES;
    
    
    int totalAds = theList.count; 
    
    //le ascundem pe cele care nu corespund
    int adTypeCorespunde, propertyTypeCorespunde, priceCorespunde, suprafataCorespunde;
    
    for(int i=0;i<totalAds;i++)
    {    TAd *oneAd = [theList getAdAtIndex:i];
        adTypeCorespunde=0;
        propertyTypeCorespunde=0;
        priceCorespunde=0;
        suprafataCorespunde=0;
        
        if ([[oneAd.ad objectForKey:@"ad_type"] isEqualToString:[apdelegate.appSession.filtre objectForKey:@"ad_type"]]) { adTypeCorespunde=1;NSLog(@"tipAnunt corespunde");}
        
        
        if([[apdelegate.appSession.filtre objectForKey:@"property_type"] count] !=0)
        { int x;
            for(x=0;x<[[apdelegate.appSession.filtre objectForKey:@"property_type"] count];x++)
            {
                if ([[[apdelegate.appSession.filtre objectForKey:@"property_type"] objectAtIndex:x] isEqualToString:[oneAd.ad objectForKey:@"property_type"]])
                { propertyTypeCorespunde=1;NSLog(@"tip proprietate corespunde");} 
                
                
                else
                { NSLog(@"nu corespunde cu %@", [[apdelegate.appSession.filtre objectForKey:@"property_type"] objectAtIndex:x]);
                }
            }
        }
        else
        {propertyTypeCorespunde=1;
        }
        
        int valoareMax,valoareMin, valoareAd;
        valoareAd = [[oneAd.ad objectForKey:@"pret"] intValue];
        valoareMax = [[apdelegate.appSession.filtre objectForKey:@"p_max"] intValue];
        valoareMin = [[apdelegate.appSession.filtre objectForKey:@"p_min"] intValue];
        
        if((valoareAd>=valoareMin)&&(valoareAd<=valoareMax)) {priceCorespunde=1; NSLog(@"pret corespunde");}
        
        /*
         valoareAd = [[fAd.ad objectForKey:@"suprafata"] intValue];
         valoareMax = [[apdelegate.appSession.filtre objectForKey:@"size_max"] intValue];
         valoareMin = [[apdelegate.appSession.filtre objectForKey:@"size_min"] intValue];
         if((valoareAd>=valoareMin)&&(valoareAd<=valoareMax)) {suprafataCorespunde=1;}
         */
        suprafataCorespunde=1; //inca nu primim suprafata unei case
        
        if((adTypeCorespunde==0)||(propertyTypeCorespunde==0)||(priceCorespunde==0)||(suprafataCorespunde==0))
        { [[self.mapView viewForAnnotation:oneAd.adlocation]setHidden:YES];
           [[self.mapView viewForAnnotation:oneAd.adlocation]setEnabled:NO];
        }
        oneAd=nil;
    }   



}

-(void) seStergFiltrele
{
    onlyFilteredAdsVisible=NO;
    
    //mutam scolul automat pentru a se vedea harta-putem sa schimbam daca nu este nevoie de asta
    [self.scrollView setContentOffset: CGPointMake(0, 0) animated:YES];    
    
    if(onlyFavAdsVisible==YES) //aratam toate faves
    {
        int totalFav = apdelegate.appSession.user.favorites.count;
        for(int i=0;i<totalFav;i++)
        {    TAd *fAd = [apdelegate.appSession.user.favorites getAdAtIndex:i];
            [[self.mapView viewForAnnotation:fAd.adlocation]setHidden:NO];
            [[self.mapView viewForAnnotation:fAd.adlocation]setEnabled:YES];
            fAd=nil;
        }    
    }
    
    else
    {
    //facem toate pinurile vizibile -de tratat cazul in care fave apasat
    int totalAds = apdelegate.appSession.globalAdList.count;
    for(int j=0;j<totalAds;j++)
    {    TAd *gAd = [apdelegate.appSession.globalAdList getAdAtIndex:j];
        [[self.mapView viewForAnnotation:gAd.adlocation]setHidden:NO];
        [[self.mapView viewForAnnotation:gAd.adlocation]setEnabled:YES];
        gAd=nil;
    }
        
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
            //[self performSelectorOnMainThread:@selector(showAdsFromData:) withObject:get_more_ads_data waitUntilDone:NO];
            
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
       NSNumber *idul = [row objectForKey:@"id"];
        int favFlag=0;
      
       if([apdelegate.appSession.user.favorites count]>0)
       {TAd *temp = [apdelegate.appSession.user.favorites getAdWithId:[idul intValue]];
           if(temp==nil){favFlag=0;}
           else{favFlag=1;NSLog(@"-----------ad deja pe map---------");}
       }
       
       if(favFlag==0)
       {
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
       
        
        [self performSelectorOnMainThread:@selector(putAnnotationForAd:) withObject:anAd waitUntilDone:NO];
        
        //[_mapView addAnnotation:anAd.adlocation]; 
        [anAd release];       
       } 
    }
    NSNumber *found = [json objectForKey:@"ads_found"];
    NSLog(@" ADS FOUND %d",found.intValue);
}
         
 -(void) putAnnotationForAd:(TAd*) theAd
{
     [_mapView addAnnotation:theAd.adlocation];
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
			//NSLog(@"annotation selected %@", ((TAnnotationView*) object).annotation.title);
			((TAnnotationView*) object).image = [UIImage imageNamed:@"redhouse.png"];
            [self showAnnotation:((TAnnotationView*) object).annotation];
			selectedAnnotation = ((TAnnotationView*) object).annotation;
			
		}
		else {
            //annotation deselected
			//NSLog(@"annotation deselected %@", ((TAnnotationView*) object).annotation.title);
            [self hideAnnotation];
            ((TAnnotationView*) object).image = [UIImage imageNamed:@"bluehouse.png"];
			//[self.detaliiAnuntViewController.view removeFromSuperview];
            //---[self hideAnnotation];
            
            // selectedAnnotation=nil;
            
			
		}
	}
}
- (void)showAnnotation:(TLocation*)annotation {
	
    //NSLog(@"showing annotation");

	[self.statisticsView.view addSubview:self.detaliiAnuntViewController.view];
    [self.detaliiAnuntViewController loadAdWithId:annotation.locationId];

    
    const int movementDistance = 316; // tweak as needed
    const float movementDuration = 0.1f; // tweak as needed // initial =0.3
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.statisticsView.view.frame = CGRectOffset(self.view.frame, 0, movementDistance);
    [UIView commitAnimations];

    [self.scrollView setContentSize:CGSizeMake(320, 732)];
}

- (void) stopFollowLocation {
	
	[self.mapView deselectAnnotation:selectedAnnotation animated:NO];
	
	//[self hideAnnotation];
	
}

- (void)hideAnnotation {
    
      
    const int movementDistance = 366; // tweak as needed
    const float movementDuration = 0.001f; // tweak as needed
    
    
    [UIView animateWithDuration:movementDuration
                     animations:^{self.statisticsView.view.frame =CGRectOffset(self.view.frame, 0, movementDistance);}
                     completion:^(BOOL completed){[self.detaliiAnuntViewController.view removeFromSuperview];}];
    [self.scrollView setContentSize:CGSizeMake(320, 782)];
}


//afisam fie anunturile favorite, fie toate anunturile
-(void) showFavAdsOnMap
{
    if(self.navigationItem.rightBarButtonItem.tag == 0)
    { if(apdelegate.appSession.user.favorites.count !=0)//daca avem favorite in lista
    {
        onlyFavAdsVisible=YES;
        NSLog(@"Show fav ads on map");
        self.navigationItem.rightBarButtonItem.tag=1;
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"starfav.png"];
        
        //deselectam pinul curent selectat(poate nu este in favorite)
        [self.mapView deselectAnnotation:selectedAnnotation animated:NO];
        
        //in cazul in care scrollul este dat in jos(nu mai este vizibila harta) si se apasa pe butonul de fav, mutam scolul automat pentru a se vedea harta-putem sa schimbam daca nu este nevoie de asta
        [self.scrollView setContentOffset: CGPointMake(0, 0) animated:YES];
        
        //ASCUNDEM TOATE ANUNTURILE SI LE AFISAM DOAR PE CELE FAVORITE       
        int totalAds = apdelegate.appSession.globalAdList.count;
        for(int j=0;j<totalAds;j++)
        {    TAd *gAd = [apdelegate.appSession.globalAdList getAdAtIndex:j];
            [[self.mapView viewForAnnotation:gAd.adlocation]setHidden:YES];
            [[self.mapView viewForAnnotation:gAd.adlocation] setEnabled:NO];
            gAd=nil;
    
        }
        
        int totalFav = apdelegate.appSession.user.favorites.count;
        for(int i=0;i<totalFav;i++)
        {    TAd *fAd = [apdelegate.appSession.user.favorites getAdAtIndex:i];
            [[self.mapView viewForAnnotation:fAd.adlocation]setHidden:NO];
            [[self.mapView viewForAnnotation:fAd.adlocation]setEnabled:YES];
            fAd=nil;
        }    
        
    if(onlyFilteredAdsVisible==YES)
        [self aplicareFiltrePeLista:apdelegate.appSession.user.favorites];
        
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
            [[self.mapView viewForAnnotation:gAd.adlocation]setEnabled:YES];
            gAd=nil;
        }
        
        if(onlyFilteredAdsVisible==YES)
            [self aplicareFiltrePeLista:apdelegate.appSession.globalAdList];
    }
    
}

-(void) hidePinWhenFavesVisibleAndCurrentAdRemovedFromFav
{

    if(onlyFavAdsVisible==YES)
    {
 [self.mapView deselectAnnotation:selectedAnnotation animated:NO];
        [[self.mapView viewForAnnotation:selectedAnnotation] setHidden:YES];
        [[self.mapView viewForAnnotation:selectedAnnotation] setEnabled:NO];
    
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
    if([apdelegate.appSession.user.personalAds count]==10)
    {UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Nu poti adauga mai mult de 10 de anunturi." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        [alertView release]; 
    }
    else
    {
    AdaugAnuntViewController * adaugAnuntView = [[[AdaugAnuntViewController alloc] initWithNibName:@"AdaugAnuntViewController" bundle:nil]autorelease];
    
    adaugAnuntView.delegate=statisticsView.myAds;
    adaugAnuntView.refreshMyAdsTable=@selector(refreshMyAdsTable);
    
    
    [self.navigationController pushViewController:adaugAnuntView animated:YES];
    }  
}
-(void)goToEditAnunt:(NSNotification*)notification
{
    AdaugAnuntViewController * adaugAnuntView = [[[AdaugAnuntViewController alloc] initWithNibName:@"AdaugAnuntViewController" bundle:nil]autorelease];
    
    NSString *indexAnunt = [notification object];
    //NSLog(@"ID-ul anuntului ales pt editare: %@",indexAnunt);
    
    adaugAnuntView.theNewAd = [apdelegate.appSession.user.personalAds getAdAtIndex:[indexAnunt intValue]];
    
    adaugAnuntView.delegate=statisticsView.myAds;
    adaugAnuntView.refreshMyAdsTable=@selector(refreshMyAdsTable);

[self.navigationController pushViewController:adaugAnuntView animated:YES];
}


-(float) Mapzoomlevel {
    
    //return 21- round(log2(_mapView.region.span.longitudeDelta * MERCATOR_RADIUS * M_PI / (180.0 * _mapView.bounds.size.width)));
    return round (_mapView.region.span.longitudeDelta * MERCATOR_RADIUS * M_PI / (180.0 * _mapView.bounds.size.width));
    
}


/////////////////////
-(void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    mapRequest = nil;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"drag");
    float zoom = [self Mapzoomlevel];
    NSLog(@"zoom: %f", zoom);
    if((hasLoadView==1)&&(onlyFavAdsVisible==NO)&&(internetActive==YES)){
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//modificari conexiune
- (void) checkNetworkStatus:(NSNotification *)notice
{
    // called after network status changes
    
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            self.internetActive = NO;
            
            break;
            
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            self.internetActive = YES;
            
            break;
            
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            self.internetActive = YES;
            
            break;
            
        }
    }
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
    
    [locationManager release];
    [super dealloc];
}
@end
