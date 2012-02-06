//
//  FirstViewController.h
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TRequest.h"
#import "AppDelegate.h"
#import "TTouchView.h"
#import "SomeView.h"
#import "MyAdsViewController.h"
#import "StatsViewController.h"
#import "DetaliiAnuntViewController.h"
#import "AdaugAnuntViewController.h"
#import "Filtre.h"

@class Reachability;

@interface MapViewController : UIViewController <MKMapViewDelegate, UINavigationBarDelegate, CLLocationManagerDelegate>
{
    BOOL _doneInitialZoom;
    IBOutlet MKMapView *mapView;
    UINavigationItem *mapNavItem;
    //
    double left,right,bottom,top;
    TRequest *mapRequest;
    BOOL hasLoadView;
    AppDelegate *apdelegate;
    
    //pentru a afla toate actiunile de touch de pe ecran
    TTouchView *touchView;
    
    TLocation *selectedAnnotation;
    /////////
   
    UIScrollView *scrollView;
    UIScrollView *subScroll;

    StatsViewController *statisticsView;
    DetaliiAnuntViewController *detaliiAnuntViewController;
    //AdaugAnuntViewController * adaugAnuntView;
    NSThread * threadRequest;
    //NSConditionLock *lock;
    int flag;
    int flag_get_more_ads;
    int flag_user_location;
    
    BOOL onlyFavAdsVisible;
    BOOL onlyFilteredAdsVisible;
    
    // pentru user location:
    CLLocationManager *locationManager;
    
    //pentru notificari legate de conexiunea la internet
    Reachability* internetReachable;
    Reachability* hostReachable;
    BOOL internetActive;
    
}
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,retain) UINavigationItem *mapNavItem;
/////
@property(nonatomic,retain) TTouchView *touchView;
@property(nonatomic,retain) TLocation *selectedAnnotation;

@property(nonatomic,retain) IBOutlet StatsViewController *statisticsView;
@property(nonatomic,retain) DetaliiAnuntViewController *detaliiAnuntViewController;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIScrollView *subScroll;
// pentru user location:
@property (nonatomic, retain) CLLocationManager * locationManager;
@property (assign) BOOL internetActive;


/////
extern NSString *const GMAP_ANNOTATION_SELECTED;
- (void) showAnnotation:(TLocation*) annotation;
- (void) hideAnnotation;

-(void)goToAdaugaAnunt;
-(void)goToEditAnunt:(NSNotification*)notification;
-(void) showFavAdsOnMap;
-(void) showAdsFromData:(NSData *)data;
-(void) getParamForReq;

-(void) threadReqMethod;


-(void) hidePinWhenFavesVisibleAndCurrentAdRemovedFromFav;


-(void) getMoreAds: (NSString *) postString;
-(void) putAnnotationForAd:(TAd*) theAd;

-(void)seAplicaFiltrele;
-(void) seStergFiltrele;
-(void)aplicareFiltrePeLista:(TAdList*)theList;

- (void) checkNetworkStatus:(NSNotification *)notice;

@end