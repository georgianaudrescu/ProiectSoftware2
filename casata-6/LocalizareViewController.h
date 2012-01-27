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
#import "TAd.h"
@interface LocalizareViewController : UIViewController<MKMapViewDelegate>
{
IBOutlet MKMapView *mapView;
    
TLocation *dropPin;
TLocation *tempLocation;
    TAd *tempAd; 
    int flag;
}
//UILongPressGestureREcognizer *longPressGesture=[[UILongPressGestureREcognizer alloc] initWithTarget: self action: @selector(handleLongPressGesture:)];

@property (retain, nonatomic) IBOutlet MKMapView *mapView;

@property(nonatomic, retain) TLocation *dropPin;
@property(nonatomic, retain) TAd *tempAd;

-(void)selLocatieNoua;
@end
