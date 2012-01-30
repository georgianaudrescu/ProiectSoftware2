//
//  AppDelegate.m
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "MapViewController.h"

#import "Informatii.h"
#import "TAppSession.h"
#import "TRequest.h"
#import "Reachability.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize navigationController= _navigationController;
@synthesize appSession, internetActive;
//@synthesize locationManager;



- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [_viewController release];
    [appSession release];
    //[locationManager release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    ////close session////// 
    
    TRequest *req = [TRequest alloc] ;
    [req initWithHost:@"http://flapptest.comule.com"];
    // NSString * postString=[NSString stringWithFormat:@"sessionTime=1326040737022&request=close%5Fsession&sid= %d", appSession.user.userId];
    NSString * postString=@"sessionTime=1326043272238&request=close%5Fsession&sid=session1";
    NSData *responseData;
    
    if([req makeRequestWithString:postString]!=0){
        responseData=[req requestData];
        //parse out the json data
        NSError* error;
        NSDictionary* json = [NSJSONSerialization 
                              JSONObjectWithData:responseData
                              options:kNilOptions 
                              error:&error];
        NSString *status=[json objectForKey:@"status"];  
        if([status isEqualToString:@"OK"])
        { NSLog(@"Session Closed");}
        else
        { NSLog(@"Session NOT Closed!");
        }
        [req release];  
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet" message:@"Nu esti conectat la internet, vei avea acces doar la anunturile favorite salvate si anunturile proprii" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];
    }
      
    
   ////close session////// 

                           
                           
    /*
    if (!self.locationManager) 
	{
		self.locationManager = [[[CLLocationManager alloc] init] autorelease];
		self.locationManager.headingFilter = kCLHeadingFilterNone;
		self.locationManager.distanceFilter = kCLDistanceFilterNone;
		self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
	}
	self.locationManager.delegate = self; 
    [locationManager startUpdatingLocation];
    */
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    
  
    self.appSession = [[TAppSession alloc] init];
    [self.appSession globalVariablesInit];
    [self.appSession readLocalData];///+++
    
    /* 
    //schimba culoarea status bar-ului de sus-din gri(default) in negru
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
    */
    
    
    // Override point for customization after application launch.
    UIViewController *mapViewController = [[[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil] autorelease];
    

    //Navigation controllerul principal-are ca radacina pagina de map
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:mapViewController] autorelease];
   
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.976 green:0.827 blue:0.015 alpha:1.0]; 
     
    
    
   self.window.rootViewController = self.navigationController;
    
    //self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    

    
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    [self.appSession saveLocalData];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    //[self.appSession readLocalData];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */


}

- (void) checkNetworkStatus:(NSNotification *)notice
{
    // called after network status changes
    
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            self.internetActive = NO;
            
            break;
            
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            self.internetActive = YES;
            
            break;
            
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            self.internetActive = YES;
            
            break;
            
        }
    }
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
