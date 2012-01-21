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


@interface MapViewController : UIViewController <MKMapViewDelegate, UINavigationBarDelegate>{
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
    BOOL onlyFavAdsVisible;
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
          
/////
extern NSString *const GMAP_ANNOTATION_SELECTED;
- (void) showAnnotation:(TLocation*) annotation;
- (void) hideAnnotation;

-(void)goToAdaugaAnunt;
-(void) showFavAdsOnMap;
-(void) showAdsFromData:(NSData *)data;
-(void) getParamForReq;
-(void) hidePinWhenFavesVisibleAndCurrentAdRemovedFromFav;

@end
