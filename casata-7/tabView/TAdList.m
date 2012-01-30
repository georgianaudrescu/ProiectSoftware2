//
//  TAdList.m
//  casata
//
//  Created by me on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TAdList.h"


@implementation TAdList
@synthesize adList, count,request;


- (id)init {
    self = [super init];
    if (self) {
        adList = [[NSMutableOrderedSet alloc]init];
        count=0;
        
    }
    return self;
}
-(TAd *)getAdWithId:(int)index
{
    TAd *rezultat = [TAd alloc];
    int x;
   
    NSNumber *nr_anunt = [[NSNumber alloc]autorelease];
    //NSLog(@"nr cautat: %d",index);
    
    for(x=0;x<count;x++)
    {rezultat = [adList objectAtIndex:x];
       
        nr_anunt = [rezultat.ad objectForKey:@"id"];
       // NSLog (@"---- la indexul: %d este id %d",x, nr_anunt.intValue);
        if (nr_anunt.intValue==index)
        {
               //NSLog (@"------match-----");            
            return [adList objectAtIndex:x];}
    }
      // NSLog (@"------nonmatch-----");    
    //rezultat=nil;
    
      
    return nil; //changed from return [adList objectAtIndex:0];
}
-(void)addAd:(TAd *)ad
{ 
    [adList addObject:ad];
    count = adList.count;
}
-(void)removeAd:(TAd *)ad
{
    [adList removeObject:ad];
    count = adList.count;
}
-(TAd *)getAdAtIndex:(int)index
{
    return [adList objectAtIndex:index];
}

-(void)removeAdAtIndex:(int)index
{
    [adList removeObjectAtIndex:index];
    count = adList.count;
}

-(int)getIndexForAd:(TAd *)ad
{
    return [adList indexOfObject:ad];
}
//requestul trebuie initializat inainte, si daca are raspuns, se apeleaza metoda pt un ob TAdList

-(void)populateListWithRequest:(TRequest *)aRequest
{
    //request = [TRequest alloc];
    
    self.request = aRequest;
    //NSData *data = [[NSData alloc] initWithData:[aRequest requestData]];
    NSData *data = [NSData dataWithData:[aRequest requestData]];


if ([data length]==0)
{
    [data release];
    NSLog(@"No data recieved from the server!");
    //return;
}
else{
NSLog(@"data fetched from server %@",data);
//NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//NSArray *arr =[string componentsSeparatedByString:@"<!--"];
//NSLog(@"Array %@:",[arr objectAtIndex:0]);
//data=[[arr objectAtIndex:0] dataUsingEncoding: [NSString defaultCStringEncoding] ];


//parse out the json data
NSError* error;
NSDictionary* json = [NSJSONSerialization 
                      JSONObjectWithData:data
                      options:kNilOptions 
                      error:&error];
NSLog(@"data JSON: %@", json); 
NSArray *allAds = [json objectForKey:@"ads"];

for(NSDictionary *row in allAds)
{
    TAd *anAd = [TAd alloc];
    [anAd TAd:(row)];
    [adList addObject:anAd];
    [anAd release];
}
    count = adList.count;
}//end of else
    
    
}


-(void) removeAllAds
{
    [adList removeAllObjects];
    count = 0;
}

-(void)dealloc
{
    //[adList release];
    //[request release];
    
    self.adList = nil;
   self.request=nil;
    
    [super dealloc];
}

@end