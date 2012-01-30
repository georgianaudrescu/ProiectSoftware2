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

@class Reachability;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate>
{   
    TAppSession *appSession;
    //IBOutlet CLLocationManager * locationManager;
    
    Reachability* internetReachable;
    Reachability* hostReachable;
    BOOL internetActive;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIViewController *viewController;
@property (nonatomic,retain) TAppSession *appSession;
//@property (nonatomic,retain) CLLocationManager * locationManager;
@property (assign) BOOL internetActive;


- (void) checkNetworkStatus:(NSNotification *)notice;



@end
