//
//  LocalizareViewController.h
//  casata
//
//  Created by me on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocalizareViewController : UIViewController<MKMapViewDelegate>
{
IBOutlet MKMapView *mapView;
    
}
@property (retain, nonatomic) IBOutlet MKMapView *mapView;

@end
