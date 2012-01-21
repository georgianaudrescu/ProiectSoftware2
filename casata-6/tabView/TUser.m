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
    
    NSNumber *idPrimit = [json objectForKey:@"userId"];
    
    if (idPrimit !=0) {
        userId=idPrimit;
        username=name;
        password=pass; 
        //initializare liste: fav, persAds, settings
        favorites = [[TAdList alloc]init];
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
    NSNumber * loginId=[json objectForKey:@"userId"];
    userId = loginId;
    NSLog(@"USser ID %@",loginId);

    
    if([loggedIn isEqualToString:@"OK"])
    { NSLog(@"Logged in succes");}
    else
    { NSLog(@"Try again, user or pass wrong");}
    
    //[request release];
    //[postString release];
    //[data release];
    //[json release];
    //[loggedIn release];
} 

- (NSNumber *) getUserId{
    return userId;
}

- (void) Logout{
    //req logout
}

-(void) NewAd:(TAd *)newad //WithImageList:(TImageList *)imgLst
{  
    //TAd * newad = [TAd alloc];
    
    //newad.imageList = [TImageList alloc];
    //newad.imageList=imgLst;
    
    request = [TRequest alloc];
    NSString *postString = [NSString stringWithFormat:@"request=add_ad&ad_name=%@&ad_text=%@&adress=%@&coord_x=%@&coord_y=%@&price=%@&currency=%@&ad_type=%@&property_type=%@&judet=%@&oras=%@&size=%@&sid=session1", [newad.ad objectForKey:@"name"],[newad.ad objectForKey:@"ad_text"],[newad.ad objectForKey:@"adress_line"],[newad.ad objectForKey:@"long"],[newad.ad objectForKey:@"lat"], [newad.ad objectForKey:@"pret"], [newad.ad objectForKey:@"moneda"], [newad.ad objectForKey:@"ad_type"], [newad.ad objectForKey:@"property_type"], [newad.ad objectForKey:@"judet"], [newad.ad objectForKey:@"oras"], [newad.ad objectForKey:@"size"]];
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
    
    NSArray *allAds = [json objectForKey:@"ads"];
    NSNumber *idad = [NSNumber alloc];
    for(NSDictionary *row in allAds)
    {
        TAd *newad2 =[TAd alloc];
        [newad2 TAd:row];
        idad = [row objectForKey:@"id"];
        newad2.imageList = [TImageList alloc];
        newad2.imageList = newad.imageList;
        [self.personalAds addAd:newad2];
    }
    // NSNumber *idad = [json objectForKey:@"idad"];
    //recomand NSNumber *idad si dupa trimiti ca parametru idad.intValue
    
    [newad UploadImagesttt:idad.intValue withImagelist:newad.imageList];
     
    //[ad release]
    
    
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
    [favorites removeAd:ad];
}
/*- (void)addLocationToFav:(TLocation *)aLocation{
    [favorites addLocation:aLocation];
}
- (void)removeLocationFromFav:(TLocation *)aLocation{
    [favorites deleteLocation:aLocation];
}
*/
-(void) setMySettings{
    //TO DO
}

-(void) dealloc{
    [super dealloc];
}

@end
