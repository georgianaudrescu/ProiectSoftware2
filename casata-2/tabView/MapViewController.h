//
//  FirstViewController.h
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, UINavigationBarDelegate>{
    BOOL _doneInitialZoom;
    IBOutlet MKMapView *mapView;
    UINavigationItem *mapNavItem;
    //
    UISearchBar *searchBar;
   }
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,retain) UINavigationItem *mapNavItem;
//
@property (nonatomic,retain) IBOutlet UISearchBar *searchBar;

-(void)goHome;
-(void)selectFiltre;


@end
