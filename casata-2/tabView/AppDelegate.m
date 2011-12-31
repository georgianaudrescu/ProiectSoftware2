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

#import "FavViewController.h"

#import "LoginViewController.h"

#import "ViewController.h"
#import "Informatii.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize viewController = _viewController;


- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
    // Override point for customization after application launch.
    UIViewController *mapViewController = [[[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil] autorelease];
    UIViewController *adaugaAnuntViewController = [[[AdaugAnuntViewController alloc] initWithNibName:@"AdaugAnuntViewController" bundle:nil] autorelease];
    UIViewController *statsViewController = [[[StatsViewController alloc] initWithNibName:@"StatsViewController" bundle:nil] autorelease];
    FavViewController *favViewController = [[[FavViewController alloc] initWithNibName:@"FavViewController" bundle:nil] autorelease];
    
    
    UIViewController *loginViewController = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
    UINavigationController *navControllerMap = [[[UINavigationController alloc] initWithRootViewController:mapViewController] autorelease];
   
    navControllerMap.navigationBar.tintColor = [UIColor colorWithRed:0.976 green:0.827 blue:0.015 alpha:1.0];    
    
    UINavigationController *navControllerFav = [[[UINavigationController alloc] initWithRootViewController:favViewController] autorelease];
    
    navControllerFav.navigationBar.tintColor = [UIColor colorWithRed:0.976 green:0.827 blue:0.015 alpha:1.0]; 
    
    
    
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navControllerMap, navControllerFav,adaugaAnuntViewController,statsViewController,loginViewController, nil];
    self.window.rootViewController = self.viewController;
    
    //self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)pageSelectedInTab:(NSString*)bTitle
{self.window.rootViewController = self.tabBarController;
   
    //in momentul in care se selecteaza un buton din home view, de aici se selecteaza si tab-ul corespunzator
    if([bTitle isEqualToString:@"Cauta anunturi"])
        self.tabBarController.selectedIndex =0;
    else if([bTitle isEqualToString:@" Anunturi in apropiere"])
        self.tabBarController.selectedIndex=0;
    else if([bTitle isEqualToString:@" Anunturi favorite"])
    {
        [Informatii selectedFavoriteChange:@"Anunturi"]; 
        self.tabBarController.selectedIndex=1;
        
    }
    else if([bTitle isEqualToString:@" Trends & statistics"])
        self.tabBarController.selectedIndex=3;
    else if([bTitle isEqualToString:@" Profile"])
        self.tabBarController.selectedIndex = 4;
    else if([bTitle isEqualToString:@" Setari & Feedback"])
        self.tabBarController.selectedIndex = 4;
    else if([bTitle isEqualToString:@" Cautari favorite"])
    {
        [Informatii selectedFavoriteChange:@"Cautari"];
        self.tabBarController.selectedIndex = 1;
        
    }
    
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
