

//
//  Created by Diana on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFav.h"
#import "TAd.h"
#import "TAdList.h"
#import "TSettings.h"
@interface TUser : NSObject
{
    
    NSString *usernameLogIn;
    NSString *passwordLogIn;
    
    TFav *myFavorites;
    TAdList *personalAds;
    TSettings *mySettings;
    TRequest *logInRequest;
    TRequest *logOutRequest;
    
    int userIdLogIn;
    TLocation  *myLocation;
    
    NSNumber *loggedIn;
    
}

@property(nonatomic,copy) NSString *usernameLogIn;
@property(nonatomic,copy) NSString *passwordLogIn;
@property(nonatomic, assign) int userIdLogIn;
@property(nonatomic, copy) NSNumber *loggedIn;
@property(nonatomic,copy) TFav *myFavorites;
@property(nonatomic,copy) TAdList *personalAds;
@property(nonatomic,copy) TSettings *mySettings;
@property(nonatomic,copy) TRequest *logInRequest;
@property(nonatomic,copy) TRequest *logOutRequest;
@property(nonatomic,copy) TLocation *myLocation;

-(void) addToFav: (TAd *) fAd;
-(void) removeFromFav: (TAd * ) rfAd;
//-(void) addToLocation: (TLocation <MKAnnotation> *) mLoc;
//-(id) removeLocation: (TLocation *) dLocation;

-(void) addNewAd: (TAd *) nAd;
-(void) editMyAd: (TAd *) eAd;
-(void) removeMyAd: (TAd *) rAd;

-(void) setMySettings: (TSettings *) nSet;
//-(NSString *) encryptedtext: (NSString *) password;

-(void) logInUserId: (int *) userId LogInUser: (NSString *) username LogInPass: (NSString *) password;

-(void) LogOut: (Boolean *) logOutTrue;


@end