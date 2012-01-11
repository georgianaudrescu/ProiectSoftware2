//
//  AppDelegate.m
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "MapViewController.h"

#import "AdaugAnuntViewController.h"

#import "StatsViewController.h"

//#import "FavViewController.h"
//#import "PersonalViewController.h"
#import "Filtre.h"
#import "ViewController.h"
#import "Informatii.h"
#import "TAppSession.h"
#import "TRequest.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize viewController = _viewController;
@synthesize appSession;


- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [_viewController release];
    [appSession release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    
  
    self.appSession = [[TAppSession alloc] init];
    [self.appSession globalVariablesInit];
    
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
    // Override point for customization after application launch.
    UIViewController *mapViewController = [[[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil] autorelease];
    UIViewController *adaugaAnuntViewController = [[[AdaugAnuntViewController alloc] initWithNibName:@"AdaugAnuntViewController" bundle:nil] autorelease];
    UIViewController *statsViewController = [[[StatsViewController alloc] initWithNibName:@"StatsViewController" bundle:nil] autorelease];
    UIViewController *filtreViewController = [[[Filtre alloc] initWithNibName:@"Filtre" bundle:nil] autorelease];

    //Navigation controllerul pt pagina de Map
    UINavigationController *navControllerMap = [[[UINavigationController alloc] initWithRootViewController:mapViewController] autorelease];
   
    navControllerMap.navigationBar.tintColor = [UIColor colorWithRed:0.976 green:0.827 blue:0.015 alpha:1.0]; 
     
    
    //navigation controller ptr pagina de Filtre
    UINavigationController *navControllerFiltre = [[[UINavigationController alloc] initWithRootViewController:filtreViewController]autorelease];
    navControllerFiltre.navigationBar.tintColor = [UIColor colorWithRed:0.976 green:0.827 blue:0.015 alpha:1.0];
    
    //navigation controllerul pt pagina Adauga anunt
    UINavigationController *navControllerAdaug = [[[UINavigationController alloc] initWithRootViewController:adaugaAnuntViewController] autorelease];
    
    navControllerAdaug.navigationBar.tintColor = [UIColor colorWithRed:0.976 green:0.827 blue:0.015 alpha:1.0];
    
    
    //navigation controllerul pt pagina statistici
    UINavigationController *navControllerStatistici = [[[UINavigationController alloc] initWithRootViewController:statsViewController] autorelease];    
    
    navControllerStatistici.navigationBar.tintColor = [UIColor colorWithRed:0.976 green:0.827 blue:0.015 alpha:1.0];  
    
    
    //view controllerul pt Home
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navControllerMap, navControllerFiltre,navControllerAdaug,navControllerStatistici, nil];
    self.window.rootViewController = self.viewController;
    
    //self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)pageSelectedInTab:(NSString*)bTitle
{
   
    //in momentul in care se selecteaza un buton din home view, de aici se selecteaza si tab-ul corespunzator
    
    if([bTitle isEqualToString:@" Anunturi in apropiere"])
        self.tabBarController.selectedIndex=0;
    else if([bTitle isEqualToString:@" Trends & statistics"])
        self.tabBarController.selectedIndex=3;
    else if([bTitle isEqualToString:@" Adauga anunt"])
        self.tabBarController.selectedIndex = 2;
    
    
  self.window.rootViewController = self.tabBarController;    
}

-(void)goToHomeScreen
{self.window.rootViewController = self.viewController;
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
    
    TRequest *req = [TRequest alloc] ;
    [req initWithHost:@"http://flapptest.comule.com"];
   // NSString * postString=[NSString stringWithFormat:@"sessionTime=1326040737022&request=close%5Fsession&sid= %d", appSession.user.userId];
    NSString * postString=@"sessionTime=1326043272238&request=close%5Fsession&sid=session1";
    NSData *responseData;
    
    if([req makeRequestWithString:postString]!=0){
        responseData=[req requestData];
    }
    
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */


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
