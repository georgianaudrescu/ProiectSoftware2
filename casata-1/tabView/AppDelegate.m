//
//  AppDelegate.m
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "MapViewController.h"

#import "SearchViewController.h"

#import "StatsViewController.h"

#import "FavViewController.h"

#import "LoginViewController.h"

#import "ViewController.h"


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
    // Override point for customization after application launch.
    UIViewController *mapviewController = [[[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil] autorelease];
    UIViewController *viewController2 = [[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil] autorelease];
    UIViewController *viewController3 = [[[StatsViewController alloc] initWithNibName:@"StatsViewController" bundle:nil] autorelease];
    UIViewController *viewController4 = [[[FavViewController alloc] initWithNibName:@"FavViewController" bundle:nil] autorelease];
    UIViewController *viewController5 = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
    UINavigationController *navControllerMap = [[[UINavigationController alloc] initWithRootViewController:mapviewController] autorelease];
   
    navControllerMap.navigationBar.tintColor = [UIColor yellowColor];                                                        
   // navControllerMap.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navControllerMap, viewController2,viewController3,viewController4,viewController5, nil];
    self.window.rootViewController = self.viewController;
    
    //self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)pageSelectedInTab:(NSString*)bTitle
{self.window.rootViewController = self.tabBarController;
    if([bTitle isEqualToString:@"Cauta anunturi"])
        self.tabBarController.selectedIndex =1;
    else if([bTitle isEqualToString:@" Anunturi in apropiere"])
        self.tabBarController.selectedIndex=0;
    else if([bTitle isEqualToString:@" Anunturi favorite"])
        self.tabBarController.selectedIndex=3;
    else if([bTitle isEqualToString:@" Trends & statistics"])
        self.tabBarController.selectedIndex=2;
    else if([bTitle isEqualToString:@" Profile"])
        self.tabBarController.selectedIndex = 4;
    

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
