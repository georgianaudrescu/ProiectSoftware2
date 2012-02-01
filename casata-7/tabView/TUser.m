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
@synthesize userId, username,phone,email;
@synthesize favorites,personalAds,request;
@synthesize  password, settings;

-(id) init{
    self=[super init];
    if(self){
        request = [TRequest alloc];
        [request initWithHost:@"http://flapptest.comule.com"];
        userId= @""; //[NSNumber numberWithInt:0];
        personalAds = [[TAdList alloc] init];
        favorites= [[TAdList alloc] init];
        username =@"";
        phone =@"";
        email=@"";
    }
    return self;
}
/*

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
*/
/*
- (NSString *) getUserId{
    return userId;
}
*/
- (void) Logout{
    //req logout
}

-(void) uploadAd:(int)adIndex
{
    
    if([username isEqualToString:@""]||[phone isEqualToString:@""]||[email isEqualToString:@""])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"ATENTIE" message:@"Nu poti publica anunturi. Completeaza datele de contact!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
       
        [alert release];
    }
    else 
    {
    TAd *anAd = [personalAds getAdAtIndex:adIndex];
    request = [TRequest alloc] ;
    [request initWithHost:@"http://flapptest.comule.com"];
    NSString *judet, *oras , *price,*coord_x, *ad_name, *coord_y, *ad_text, *size, *adress;
    //ad_type, property_type, currency
    
    
    int tip_proprietate;
    if([[anAd.ad objectForKey:@"property_type"] isEqualToString:@"Garsoniera"])
    { tip_proprietate=1;}
    else if([[anAd.ad objectForKey:@"property_type"] isEqualToString:@"Apartament 2 camere"])
    { tip_proprietate=2;}
    else if([[anAd.ad objectForKey:@"property_type"] isEqualToString:@"Apartament 3 camere"])
    { tip_proprietate=3;}
    else if([[anAd.ad objectForKey:@"property_type"] isEqualToString:@"Apartament 4 camere"])
    { tip_proprietate=4;}
    else 
    { tip_proprietate=5;}
    
    
    int tip_anunt;
    if([[anAd.ad objectForKey:@"ad_type"] isEqualToString:@"rent"])
    { tip_anunt=1;}
    else 
    { tip_anunt=2;}
    
    
    int moneda;
    if([[anAd.ad objectForKey:@"moneda"] isEqualToString:@"euro"])
    { moneda=1;}
        else 
    { moneda=2;}
    
    
    
    judet = [anAd.ad objectForKey:@"judet"];
    oras = [anAd.ad objectForKey:@"oras"];
    price = [anAd.ad objectForKey:@"pret"];
    //coord_x = [anAd.ad objectForKey:@"lat"];
    //coord_y = [anAd.ad objectForKey:@"long"];
    coord_x = [anAd.ad objectForKey:@"long"];
    coord_y = [anAd.ad objectForKey:@"lat"];
    ad_name = [anAd.ad objectForKey:@"name"];
    ad_text = [anAd.ad objectForKey:@"ad_text"];
    size = [anAd.ad objectForKey:@"size"];
    adress= [anAd.ad objectForKey:@"adress_line"];
    NSString * postString = [[NSString alloc] initWithFormat:@"judet=%@&oras=%@&ad_type=%d&request=add_ad&property_type=%d&sessionTime=1327715431897&sid=2&price=%@&currency=%d&coord_x=%@&ad_name=%@&coord_y=%@&ad_text=%@&size=%@&adress=%@",judet,oras,tip_anunt,tip_proprietate,price,moneda,coord_x,ad_name,coord_y,ad_text,size,adress];
    NSLog(@"POST STRING: %@", postString);
    
    NSData * data;
    if ([request makeRequestWithString:postString]!=0)
    {
        data = [request requestData];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        // verificat STATUS = OK:
        NSDictionary * raspuns = [request responseDictionaryOfRequest];
        NSLog(@"RASPUNS DICTIONARY: %@",raspuns);
        NSString* status = [raspuns objectForKey:@"status"];
        NSLog(@"STATUS : %@", status);
        if ([status isEqualToString:@"OK"])
        {
            NSLog(@"STATUS OK! ");
        // primit id-ul anuntului si atribuit in Dict:
            NSString * idul = [[[raspuns objectForKey:@"ads"] objectAtIndex:0] objectForKey:@"id"];
            [anAd.ad setObject:idul forKey:@"id"];
            NSLog(@"id anunt:%@", [anAd.ad objectForKey:@"id"]);
        // upload de imagini
        // upload STATUS = OK-metoda retuneaza yes(din imagelist)
        // publicat = YES:
           // NSString * publicat = [anAd.ad objectForKey:@"publicat"];
           NSString *publicat = @"YES";
            [anAd.ad setObject:publicat forKey:@"publicat"];
            NSLog(@"Publicat : %@", [anAd.ad objectForKey:@"publicat"]);
        }
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atentie!" message:@"Anuntul nu a putut fi publicat! Recomandam verificarea conexiunii la internet!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    }
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
-(void)setid:(NSString *)string
{
    self.userId = [[NSString alloc] initWithString:string];
}

-(void) dealloc{
    [favorites release];
    [personalAds release];
    [super dealloc];
}

@end
