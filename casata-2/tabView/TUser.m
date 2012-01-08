//
//  TUser.m
//  casata
//
//  Created by Oana B on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TUser.h"
#import "TRequest.h"

@implementation TUser
@synthesize userId, username, password,phone,email;
@synthesize favorites, settings,personalAds,request;

-(id) init{
    self=[super init];
    if(self){
        request = [TRequest alloc];
        [request initWithHost:@"http://flapptest.comule.com"];
        userId=0;
    }
    return self;
}

- (id) registerUserWithName:(NSString *)name WithPassword:(NSString*)pass WithPhone:(NSString *)aPhone AndEmail:(NSString *)someEmail{
  
    ///
    ///req de creare cont. primesc user id
    ///
        // NSString * postString = @"pass=test&sessionTime=1325975657349&name=test&request=login";
    NSString * postString =[NSString stringWithFormat:@"pass=%@&mail=%@&sessionTime=1325983562561&name=%@&phone=%@&request=create%5Facc",pass,someEmail,name,aPhone];
    NSData *responseData;
    
    if([request makeRequestWithString:postString]!=0){
        responseData=[request requestData];
    }
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:responseData
                          options:kNilOptions 
                          error:&error];
    NSLog(@"data JSON: %@", json); 
    
    int *idPrimit = (int *)[json objectForKey:@"userId"];
    
    if (idPrimit !=0) {
        userId=idPrimit;
        username=name;
        password=pass; 
        //initializare liste: fav, persAds, settings
        favorites = [[TFav alloc]init];
        personalAds = [[TAdList alloc] init];
        settings = [[TSettings alloc] init];
    }
    else 
    {
        NSLog(@"eroare in crearea unui nou user");
        return NULL;
    }
    
    [postString release];
    [request release];
    return self;
}

-(void) LogInUser: (NSString *) usernameLogIn LogInPass: (NSString *) passwordLogIn {
    request = [TRequest alloc];
    [request initWithHost:@"http://flapptest.comule.com"];
    NSString *postString = [NSString stringWithFormat:@"request=login&name=%@&pass=%@&sid=session1", usernameLogIn, passwordLogIn];
    NSData * data;
    if([request makeRequestWithString:postString]!=0){
        data=[request requestData];
    }
    
    if ([data length]==0)
    {
        [data release];
        NSLog(@"No data recieved from the server!");
        return;
    }
    NSLog(@"data fetched from server %@",data);
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:data
                          options:kNilOptions 
                          error:&error];
    NSLog(@"data JSON: %@", json); 
    
    NSString *loggedIn=[json objectForKey:@"status"];  
    if([loggedIn isEqualToString:@"OK"])
    { NSLog(@"Logged in succes");}
    else
    { NSLog(@"Try again, user or pass wrong");}
    
    [request release];
    [postString release];
    [data release];
    [json release];
    [loggedIn release];
} 

- (void) Logout{
    //req logout
}

- (void) addNewAdd:(TAd *)ad{
    //req new_ad
    //primesc adId
    //adaug ad in lista de personalAds
    [personalAds addAd:ad];
    //sync personalAds cu serverul
}
- (void) editMyAd:(TAd *) ad{
    //req edit_ad
}
- (void) removeMyAd:(TAd *)ad{
    //req remove_ad
    //scot ad-ul din personalAds
    [personalAds removeAd:ad];
}

- (void)addToFav:(TAd *)ad{
    //adaugare in lista favorites
    //req add_fav
    //se actualizeaza lista de favAd salvata local
    [favorites addAd:ad];
}
- (void)removeFromFav:(TAd *)ad{
    //req pentru remFav (nu este deocamdata pe server)
    //se actualizeaza lista de favAd salvata local
    [favorites deleteAd:ad];
}
- (void)addLocationToFav:(TLocation *)aLocation{
    [favorites addLocation:aLocation];
}
- (void)removeLocationFromFav:(TLocation *)aLocation{
    [favorites deleteLocation:aLocation];
}

-(void) setMySettings{
    //TO DO
}

-(void) dealloc{
    [super dealloc];
}

@end
