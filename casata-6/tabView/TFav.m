//
//  TFav.m
//  casata
//
//  Created by me on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFav.h"

@implementation TFav
@synthesize favAdsList, favSearchList,favLocationList;
- (id)init {
    self = [super init];
    if (self) {
        favSearchList= [[TSearchList alloc]init];
        favLocationList=[[TLocationList alloc]init];
        favAdsList=[[TAdList alloc]init];
    }
    return self;
}
-(void) deleteLocation:(TLocation *)location
{
    [favLocationList removeLocation:location];
    
}
-(void)deleteLocationAtIndex:(int)index
{
    [favLocationList removeLocationAtIndex:index];
}

-(void) addLocation:(TLocation *)location
{
    [favLocationList addLocation:location];
}

-(TLocation*) getLocationAtIndex:(int)index
{
   return [favLocationList getLocationFromIndex:index];
}

-(void) deleteAd:(TAd *)ad
{
    [favAdsList removeAd:ad];
}
-(void)deleteAdAtIndex:(int)index
{
    [favAdsList removeAdAtIndex:index];
}
-(void) addAd:(TAd *)ad
{
    [favAdsList addAd:ad];
}
-(TAd *) getAdAtIndex:(int)index
{
    return [favAdsList getAdAtIndex:index];
}



-(void) deleteSearch:(TSearch *)search
{
[favSearchList removeSearch:search];
}

-(void)deleteSearchAtIndex:(int)index
{
    [favSearchList removeSearchAtIndex:index];
}

-(void) addSearch:(TSearch *)search
{
    [favSearchList addSearch:search];
}

-(TSearch *) getSearchAtIndex:(int)index
{
    return [favSearchList getSearchAtIndex:index];
}


-(void)saveFavorites
{
}
-(void)loadFavorites
{
}

-(void)dealloc
{
    self.favAdsList=nil;
    self.favLocationList =nil;
    self.favSearchList=nil;
    [super dealloc];
}
@end
