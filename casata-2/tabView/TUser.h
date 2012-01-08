//
//  TUser.h
//  casata
//
//  Created by Oana B on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#if !defined(TUSER)
#define TUSER 1

#import <Foundation/Foundation.h>

#import "TFav.h"
#import "TSettings.h"
#import "TAdList.h"

@interface TUser : NSObject{
    int *userId;
    NSString *username;
    NSString *password;
    NSString *phone;
    NSString *email;
    TAdList *personalAds;
    TFav *favorites;
    TSettings *settings;
    TRequest *request;
}

@property (nonatomic) int  *userId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy)NSString *password;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *email;
@property (nonatomic, retain)TAdList *personalAds;
@property (nonatomic, copy)TFav *favorites;
@property (nonatomic, copy)TSettings *settings;
@property (nonatomic,copy) TRequest *request;

-(void) NewAd:(TAd *)newad ;//WithImageList:(TImageList *)imgLst;

- (id) init;
- (id) registerUserWithName:(NSString *)name WithPassword:(NSString*)pass WithPhone:(NSString *)phone AndEmail:(NSString *)email;
-(void) LogInUser: (NSString *) usernameLogIn LogInPass: (NSString *) passwordLogIn;
- (void) Logout;

- (void) addNewAdd:(TAd *)ad;
- (void) editMyAd:(TAd *) ad;
- (void) removeMyAd:(TAd *)ad;

- (void)addToFav:(TAd *)ad;
- (void)removeFromFav:(TAd *)ad;
- (void)addLocationToFav:(TLocation *)aLocation;
- (void)removeLocationFromFav:(TLocation *)aLocation;

-(void) setMySettings;

@end

#endif //TUSER
