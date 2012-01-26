//
//  LocalizareViewController.h
//  casata
//
//  Created by me on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TLocation.h"
@interface LocalizareViewController : UIViewController<MKMapViewDelegate>
{
IBOutlet MKMapView *mapView;
    
TLocation *dropPin;
    
}
//UILongPressGestureREcognizer *longPressGesture=[[UILongPressGestureREcognizer alloc] initWithTarget: self action: @selector(handleLongPressGesture:)];

@property (retain, nonatomic) IBOutlet MKMapView *mapView;

@property(nonatomic, retain) TLocation *dropPin;

-(void)selLocatieNoua;
@end
