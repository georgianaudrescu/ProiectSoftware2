//
//  TAppSession.m
//  casata
//
//  Created by me on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TAppSession.h"


@implementation TAppSession
@synthesize globalAdList,filtre,currentLocation,user, currentSearch;  
@synthesize globalSettings,statistics;
//variabilele globale


-(void)addCurrentSearchResultsToGlobalAdList ///ar trebui puse pe harta mai intai>>varianta in care aceasta metoda returneaza lista/
{
    user =[[TUser alloc] init];
    
    
    TAdList *searchResults = [TAdList alloc];
    searchResults = [currentSearch Search:filtre];
    int i;
    for(i=0;i<searchResults.count;i++)
        [globalAdList addAd:[searchResults getAdAtIndex:i]];
    searchResults=nil;

}

-(NSMutableString*)getStringForFilters
{
    
    NSArray *prop = [self.filtre objectForKey:@"property_type"];
    
    NSMutableString *tipuriProprietate=[NSMutableString stringWithString:@""];
    NSMutableString *filtreString;
    
    if(prop.count==0)
    {      filtreString = [NSMutableString stringWithFormat:@"&ad_type=%@&size_min=%d&size_max=%d&p_min=%d&p_max=%d",[self.filtre objectForKey:@"ad_type"],[[self.filtre objectForKey:@"size_min"] intValue],[[self.filtre objectForKey:@"size_max"] intValue],[[self.filtre objectForKey:@"p_min"] intValue],[[self.filtre objectForKey:@"p_max"] intValue]];
    }
    else
    { int x;
        
        for(x=0;x<prop.count;x++)
        {  if(x>0)
            {[tipuriProprietate appendString:@","];
              
            }
        [tipuriProprietate appendString:[[prop objectAtIndex:x] lowercaseString]];
        }
        
      filtreString = [NSMutableString stringWithFormat:@"&ad_type=%@&size_min=%d&size_max=%d&p_min=%d&p_max=%d&property_type=%@",[self.filtre objectForKey:@"ad_type"],[[self.filtre objectForKey:@"size_min"] intValue],[[self.filtre objectForKey:@"size_max"] intValue],[[self.filtre objectForKey:@"p_min"] intValue],[[self.filtre objectForKey:@"p_max"] intValue],tipuriProprietate];
    }
    
    return  filtreString;
}

-(NSDictionary *) getDataForLocalSave
{
    
    NSMutableArray *personalAdsArray=[[NSMutableArray alloc]init];
    for(int x=0;x<[user.personalAds count];x++)
    {
        TAd *tempAd = [user.personalAds getAdAtIndex:x];
        NSArray * imageListArray = [tempAd.imageList getArrayOfDictionariesFromImageList];
       // NSData *thumbnailData = [tempAd.thumb getDictionaryForImage];
        NSDictionary * adDict = [[[NSDictionary alloc] initWithObjectsAndKeys:tempAd.ad,@"detalii",imageListArray,@"imageList",nil]autorelease] ;
        
        NSLog(@"PERSONAL AD NR %d : %@", x, adDict);
        [personalAdsArray addObject:adDict];
   }
    
    
    NSMutableArray *favoritesAdsArray=[[NSMutableArray alloc]init];
    for(int x=0;x<[user.favorites count];x++)
    {
        TAd *tempAd = [user.favorites getAdAtIndex:x];
       // NSArray * imageListArray = [tempAd.imageList getArrayOfDictionariesFromImageList];
        // NSData *thumbnailData = [tempAd.thumb getDictionaryForImage];
        //NSDictionary * adDict = [[[NSDictionary alloc] initWithObjectsAndKeys:tempAd.ad,@"detalii",imageListArray,@"imageList",nil]autorelease] ;
        NSDictionary * adDict = [[[NSDictionary alloc] initWithObjectsAndKeys:tempAd.ad,@"detalii",nil] autorelease];
        NSLog(@"FAVORITE AD NR %d : %@", x, adDict);
        [favoritesAdsArray addObject:adDict];
       
    }

    NSDictionary * userDict = [[[NSDictionary alloc] initWithObjectsAndKeys:user.userId,@"userId",user.username,@"username", user.email,@"email",user.phone,@"phone",personalAdsArray,@"personalAds",favoritesAdsArray,@"favoritesAds", nil]autorelease];
    NSLog(@"user: %@, %@,%@,%@", user.userId, user.username, user.email, user.phone);
    NSLog(@"USER DICTIONARY: %@", userDict);
    return userDict;
   
}


-(void) saveLocalData
{
    // aflam calea catre documentele aplicatiei:
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docDirectory = [arrayPaths objectAtIndex:0];
    
    //scriem datele in fisiser local:
    NSString *filePath = [docDirectory stringByAppendingString:@"/CasaTa.txt"];
    NSLog(@"PATH: %@",filePath);
    NSDictionary * dataToSave = [self getDataForLocalSave];
    NSLog(@"DATA TO SAVE; %@", dataToSave);
    [dataToSave writeToFile:filePath atomically:NO];
    
}


-(void) readLocalData
{
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docDirectory = [arrayPaths objectAtIndex:0];
    NSString *filePath = [docDirectory stringByAppendingString:@"/CasaTa.txt"];
    
    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    if ([dataDict count] !=0 )
    {
    NSArray * favoritesAds = [dataDict objectForKey:@"favoritesAds"];
        if(favoritesAds != nil)
        {
            if (self.user.favorites.count ==0)
            {
           // [self.favorites removeAllAds]; 
            int nr = [favoritesAds count];
            for (int x=0;x<nr;x++)
            {
                /*TAd * anAd = [TAd alloc];
                [anAd TAd:[[favoritesAds objectAtIndex:x] objectForKey:@"detalii"]];
                [anAd initImageList];
                
               // TImage *tempImg = [TImage alloc];
               // tempImg initWithDictionary:[[favoritesAds objectAtIndex:x] objectForKey:@"imageList"]
               // [anAd.imageList a
                
                [self.user.favorites addAd:anAd];
                [anAd release]; 
                */
               // NSLog (@"dict cum este in mem:%@",[[favoritesAds objectAtIndex:x] objectForKey:@"detalii"]);///
                
                TAd * anAd = [TAd alloc];
                [anAd readFromMemory:[[favoritesAds objectAtIndex:x] objectForKey:@"detalii"]];
                if([[[favoritesAds objectAtIndex:x] objectForKey:@"imageList"] count]!=0)
                {NSLog(@"Are imagini");                    
                    [anAd initImageList];
                    
                    [anAd.imageList populateImageListFromArray:[[favoritesAds objectAtIndex:x] objectForKey:@"imageList"]]; 
                    
                    //////////////thumbnail  
                    if([anAd.imageList count]>0)
                    { //NSLog(@"avem imagini pt anuntul din arhiva");
                        //cazul pt thumbnail, de pus in lista
                        int d = [anAd.imageList indexOfDefaultImage];
                        CGSize thumbSize = CGSizeMake(100, 100);
                        [anAd thumbnailWithTImage:[anAd.imageList getImageAtIndex:d] scaledToSize:thumbSize];
                    }
                    
                    
                    
                }
                else
                {NSLog(@"NU are imagini");  
                }    
                //CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(44, 26) ;
                //NSLog(@"anuntul are lat:%@ si long:%@",[anAd.ad objectForKey:@"lat"], [anAd.ad objectForKey:@"long"]); 
                CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([[anAd.ad objectForKey:@"lat"] doubleValue], [[anAd.ad objectForKey:@"long"] doubleValue]) ;                    anAd.adlocation = [TLocation alloc];
                [anAd.adlocation initWithTitle:@"locatie" andSubtitle:@"curenta" andCoord:coord];
                anAd.adlocation.locationId= [[anAd.ad objectForKey:@"id"] intValue];
                NSLog(@"Creez locatia cu coord: %f si %f",coord.latitude, coord.longitude);
               // NSLog(@"adresa:%@ pret:%d",[anAd.ad objectForKey:@"adress_line"], [[anAd.ad objectForKey:@"pret"] intValue]);
                //NSLog(@"dic fav luat din mem:%@", anAd.ad);    
                       
                       
                       // TImage *tempImg = [TImage alloc];
                // tempImg initWithDictionary:[[personalAds objectAtIndex:x] objectForKey:@"imageList"]
                // [anAd.imageList a
                
                [self.user.favorites addAd:anAd];
                [anAd release];
               
            }
            }
        }
        
    NSArray * personalAds = [dataDict objectForKey:@"personalAds"];
        if(personalAds != nil)
        {
            if (self.user.personalAds.count ==0)
            {
                // [self.user.personalAds removeAllAds]; 
                int nr = [personalAds count];
                for (int x=0;x<nr;x++)
                {
                    TAd * anAd = [TAd alloc];
                    [anAd createAd:[[personalAds objectAtIndex:x] objectForKey:@"detalii"]];
                    if([[[personalAds objectAtIndex:x] objectForKey:@"imageList"] count]!=0)
                    {NSLog(@"Are imagini");                    
                    [anAd initImageList];
                        
                        [anAd.imageList populateImageListFromArray:[[personalAds objectAtIndex:x] objectForKey:@"imageList"]]; 
                        
                     //////////////thumbnail  
                        if([anAd.imageList count]>0)
                        { //NSLog(@"avem imagini pt anuntul din arhiva");
                            int d = [anAd.imageList indexOfDefaultImage];
                            CGSize thumbSize = CGSizeMake(75, 75);
                            [anAd thumbnailWithTImage:[anAd.imageList getImageAtIndex:d] scaledToSize:thumbSize];
                        }
                        
  
                        
                    }
                    else
                    {NSLog(@"NU are imagini");  
                    }    
                    /*CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([[anAd.ad objectForKey:@"lat"] doubleValue], [[anAd.ad objectForKey:@"long"] doubleValue]) ;
                    TLocation * tempLoc = [[TLocation alloc] initWithTitle:@"locatie" andSubtitle:@"curenta" andCoord:coord];
                    anAd.adlocation = tempLoc;
                    NSLog(@"Creez locatia cu coord: %f si %f",coord.latitude, coord.longitude);
                    
                    [tempLoc release];
                   */
                    //CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(44, 26) ;
                    //NSLog(@"anuntul are lat:%@ si long:%@",[anAd.ad objectForKey:@"lat"], [anAd.ad objectForKey:@"long"]); 
                    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([[anAd.ad objectForKey:@"lat"] doubleValue], [[anAd.ad objectForKey:@"long"] doubleValue]) ;                    anAd.adlocation = [TLocation alloc];
                    [anAd.adlocation initWithTitle:@"locatie" andSubtitle:@"curenta" andCoord:coord];
                      NSLog(@"Creez locatia cu coord: %f si %f",coord.latitude, coord.longitude);
                    
                    // TImage *tempImg = [TImage alloc];
                    // tempImg initWithDictionary:[[personalAds objectAtIndex:x] objectForKey:@"imageList"]
                    // [anAd.imageList a
                    
                    [self.user.personalAds addAd:anAd];
                    [anAd release];
                }
            }

        }
    
    NSString * userid = [dataDict objectForKey:@"userId"];
    NSString * username = [dataDict objectForKey:@"username"];
    NSString * email = [dataDict objectForKey:@"email"];
    NSString * phone = [dataDict objectForKey:@"phone"];
        
    self.user.userId = userid;
    self.user.username = username;
    self.user.email = email;
    self.user.phone = phone;
    
    NSLog(@"DATA from local memory: %@", dataDict);
    }
    
   else
   {
       self.user.userId = [self generateUniqueString];
       NSLog(@"no data in local memory, generate unique id=%@", self.user.userId);
       
   }
}

-(NSString *)generateUniqueString
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef uString = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    [(NSString*) uString autorelease];
    return (NSString*)uString;
}
-(void)dealloc
{
    self.globalAdList=nil; //variabile globale release
    self.filtre=nil;
    //--self.favorites=nil;
    self.currentLocation = nil;
    self.user=nil;
    self.currentSearch=nil;
    self.globalSettings=nil;
    self.statistics=nil;
    [super dealloc];
}
-(void)globalVariablesInit
{  globalAdList = [[TAdList alloc]init];
    user = [[TUser alloc] init];
    //currentSearch = [TSearch alloc];
    //globalSettings = [[TSettings alloc]init];
    //filtre = [[NSMutableDictionary alloc]init];
    //--favorites = [[TAdList alloc]init];
    currentLocation = [TLocation alloc];
    statistics = [[TStatisticsList alloc]init];
}

@end
