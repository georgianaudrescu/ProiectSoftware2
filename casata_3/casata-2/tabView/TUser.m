//
//  TUser.h
//  casata
//
//  TUser.m
//  casata
//
//  Created by Diana on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TUser.h"
#import "TFav.h"
#import "TAd.h"
#import "TRequest.h"
#import "TAdList.h"
@implementation TUser

@synthesize usernameLogIn, passwordLogIn, userIdLogIn, myFavorites, personalAds, mySettings,logInRequest, logOutRequest,loggedIn, myLocation; 



-(id) init
{
    self=[super init];
    if (self) {
        usernameLogIn= [[NSString alloc]init];
        passwordLogIn= [[NSString alloc]init];        
        self.myFavorites=[[TFav alloc]init];
    }
    return self;
}



-(void)addToFav: (TAd *) fAd;
{
    [myFavorites.favAdsList addObject: fAd];
    
}

-(void)removeFromFav:(TAd *)rfAd;

{ [myFavorites.favAdsList removeObject:rfAd];
    
}


-(void) addNewAd: (TAd *) nAd;
{
    [personalAds.adList addObject:nAd];
    [nAd NewAd: nAd];
    
}

-(void) editMyAd:(TAd *)eAd
{  [personalAds.adList getObject:eAd];
    [personalAds.adList addObject:eAd];
    [eAd NewAd:eAd];
    //?
}

-(void) removeMyAd:(TAd *)rAd
{
    [personalAds.adList removeObject:rAd];
    
}

-(void) addToLocation:(TLocation *)nLocation{
    
    [myLocation addObject:nLocation];
    [myFavorites.favLocationList addObject:nLocation];
}

-(void) removelocation:(TLocation *)rLocation{
    [myFavorites.favLocationList removeObject:rLocation];
}
//-(void) setMySettings:(TSettings *)nSet{}



-(void) logInUserId: (int *) userIdLogIn LogInUser: (NSString *) usernameLogIn LogInPass: (NSString *) passwordLogIn;
{
    
    logInRequest = [TRequest alloc] ;
    [logInRequest initWithHost:@"http://flapptest.comule.com"];
    NSString *postString = [NSString stringWithFormat:@"request=logInAttempt&userIdLogIn=%@&usernameLogIn=%@&passwordLogIn=%@&sid=session1", userIdLogIn,usernameLogIn, passwordLogIn];
    NSData * data;
    if([logInRequest makeRequestWithString:postString]!=0){
        data=[logInRequest requestData];
    }
    
    if ([data length]==0)
    {
        [data release];
        NSLog(@"No data recieved from the server!");
        return 0;
    }
    
    
    
    NSLog(@"data fetched from server %@",data);
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:data
                          options:kNilOptions 
                          error:&error];
    NSLog(@"data JSON: %@", json); 
    NSNumber *loggedIn = [json objectForKey:@"logInStatus"];
    if(loggedIn== 1)
    { NSLog(@"Logged in succes");}
    else
    { NSLog(@"Try again, user or pass wrong");}
}

-(void) LogOut:(Boolean *)logOutTrue
{
    logOutRequest = [TRequest alloc] ;
    [logOutRequest initWithHost:@"http://flapptest.comule.com"];
    NSString *postString = [NSString stringWithFormat:@"request=logOutAttempt&userIdLogIn=%@&usernameLogIn=%@&passwordLogIn=%@&sid=session1", userIdLogIn,usernameLogIn,passwordLogIn];
    NSData * data;
    if([logOutRequest makeRequestWithString:postString]!=0){
        data=[logInRequest requestData];
    }
    
    if ([data length]==0)
    {
        [data release];
        NSLog(@"No data recieved from the server!");
        return 0;
    }
    
    
    
    NSLog(@"data fetched from server %@",data);
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:data
                          options:kNilOptions 
                          error:&error];
    NSLog(@"data JSON: %@", json); 
    NSNumber *loggedIn = [json objectForKey:@"logInStatus"];
    if(loggedIn== 1)
    { NSLog(@"Not logged out, try again");}
    else
    {NSLog(@"Logged out");}
}



-(void) dealloc
{
    self.usernameLogIn=nil;
    self.passwordLogIn=nil;
    [super dealloc];
}
@end
