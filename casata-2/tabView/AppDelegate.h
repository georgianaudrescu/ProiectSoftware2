//
//  AppDelegate.h
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFav.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{   //global variables
    NSMutableOrderedSet *globalAdList;
    TFav *favorites;
    NSMutableDictionary *filtre; 
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UIViewController *viewController;

@property(nonatomic, retain) NSMutableOrderedSet *globalAdList;
@property(nonatomic,retain) NSMutableDictionary *filtre;;
@property(nonatomic,retain) TFav *favorites;

-(void)pageSelectedInTab:(NSString*)bTitle;
-(void)goToHomeScreen;

//global variables initalization
-(void)globalVariablesInit;

@end
