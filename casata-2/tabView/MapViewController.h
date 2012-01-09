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

@interface MapViewController : UIViewController <MKMapViewDelegate, UINavigationBarDelegate>{
    BOOL _doneInitialZoom;
    IBOutlet MKMapView *mapView;
    UINavigationItem *mapNavItem;
    //
    UISearchBar *searchBar;
    double left,right,bottom,top;
    TRequest *mapRequest;
    BOOL hasLoadView;
    AppDelegate *apdelegate;
   }
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,retain) UINavigationItem *mapNavItem;
//
@property (nonatomic,retain) IBOutlet UISearchBar *searchBar;

-(void)goHome;
-(void)selectOptiuni;
-(void)detaliiAnunt:(id)sender;
-(void) showAdsFromData:(NSData *)data;
-(void) getParamForReq;

@end
