//
//  AppDelegate.h
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAppSession.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>
{   
    TAppSession *appSession;
    IBOutlet CLLocationManager * locationManager;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIViewController *viewController;
@property (nonatomic,retain) TAppSession *appSession;
@property (nonatomic,retain) CLLocationManager * locationManager;

-(void)enterApplication;



@end
