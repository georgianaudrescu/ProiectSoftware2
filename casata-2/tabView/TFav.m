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
        favSearchList= [[NSMutableOrderedSet alloc]init];
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

-(void)saveFavorites
{
}
-(void)getFavorites
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
