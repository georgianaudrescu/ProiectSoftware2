//
//  TFav.h
//  casata
//
//  Created by me on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLocationList.h"
#import "TAdList.h"
#import "TSearchList.h"


@interface TFav : NSObject
{
    TAdList *favAdsList;
    TLocationList *favLocationList;
    TSearchList *favSearchList;
}
@property(nonatomic,copy) TAdList *favAdsList;
@property(nonatomic,copy)TLocationList *favLocationList;
@property(nonatomic,copy)TSearchList *favSearchList;

-(void) deleteLocation:(TLocation *)location;
-(void)deleteLocationAtIndex:(int)index;
-(void) addLocation:(TLocation *)location;
-(TLocation *) getLocationAtIndex:(int)index;

-(void) deleteAd:(TAd *)ad;
-(void)deleteAdAtIndex:(int)index;
-(void) addAd:(TAd *)ad;
-(TAd *) getAdAtIndex:(int)index;

-(void) deleteSearch:(TSearch *)search;
-(void)deleteSearchAtIndex:(int)index;
-(void) addSearch:(TSearch *)search;
-(TSearch *) getSearchAtIndex:(int)index;


-(void)saveFavorites;
-(void)loadFavorites;

@end
