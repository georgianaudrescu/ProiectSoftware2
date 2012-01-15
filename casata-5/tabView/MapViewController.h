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
    /////
    IBOutlet UIView *customCalloutView;
    TTouchView *touchView;
    TLocation *selectedAnnotation;
    /////////
    UILabel *adresaAnuntLabel;
    UILabel *pretAnuntLabel;
    UILabel *suprafataAnuntLabel;
    UILabel *tipAnuntLabel;
    UIImageView *thumbnailAnuntImageView;
    UIButton *favoritAnuntButton;
    UIButton *detaliiButton;
    //
    //UIView *statisticsView;
    StatsViewController *statisticsView;
    UIScrollView *scrollView;
    UIScrollView *subScroll;
    SomeView *someView;
    AdaugAnuntViewController * adaugAnuntView;
    
}
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,retain) UINavigationItem *mapNavItem;
/////
@property(nonatomic,retain) IBOutlet UIView *customCalloutView;
@property(nonatomic,retain) TTouchView *touchView;
@property(nonatomic,retain) TLocation *selectedAnnotation;
/////
@property(nonatomic,retain) IBOutlet UILabel *adresaAnuntLabel;
@property(nonatomic,retain) IBOutlet UILabel *pretAnuntLabel;
@property(nonatomic,retain) IBOutlet UILabel *suprafataAnuntLabel;
@property(nonatomic,retain) IBOutlet UILabel *tipAnuntLabel;
@property(nonatomic, retain) IBOutlet UIImageView *thumbnailAnuntImageView;
@property(nonatomic,retain) IBOutlet UIButton *favoritAnuntButton, *detaliiButton;
//@property(nonatomic,retain) IBOutlet UIView *statisticsView;
@property(nonatomic,retain) IBOutlet StatsViewController *statisticsView;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIScrollView *subScroll;
          
/////
extern NSString *const GMAP_ANNOTATION_SELECTED;
- (void) showAnnotation:(TLocation*) annotation;
- (void) hideAnnotation;
-(IBAction)closePopup:(id)sender;
-(IBAction)addToFav:(id)sender;
-(void) showFavAdsOnMap;

-(void)goToAdaugaAnunt;
//-(void)showMyAdsOnMap;




-(IBAction)detaliiAnunt:(id)sender;
-(void) showAdsFromData:(NSData *)data;
-(void) getParamForReq;



///
//- (IBAction)switchToFilter:(id)sender;
//- (IBAction)swithToMyAds:(id)sender;

@end
