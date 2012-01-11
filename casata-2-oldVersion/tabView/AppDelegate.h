//
//  AppDelegate.h
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAppSession.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{   
    TAppSession *appSession;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UIViewController *viewController;
@property (nonatomic,retain) TAppSession *appSession;

-(void)pageSelectedInTab:(NSString*)bTitle;
-(void)goToHomeScreen;



@end
