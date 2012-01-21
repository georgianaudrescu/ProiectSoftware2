//
//  TAppSession.m
//  casata
//
//  Created by me on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TAppSession.h"


@implementation TAppSession
@synthesize globalAdList,favorites,filtre,currentLocation,user, currentSearch;  
@synthesize globalSettings,statistics;
//variabilele globale


-(void)addCurrentSearchResultsToGlobalAdList ///ar trebui puse pe harta mai intai>>varianta in care aceasta metoda returneaza lista/
{
    TAdList *searchResults = [TAdList alloc];
    searchResults = [currentSearch Search:filtre];
    int i;
    for(i=0;i<searchResults.count;i++)
        [globalAdList addAd:[searchResults getAdAtIndex:i]];
    searchResults=nil;

}
-(void)dealloc
{
    self.globalAdList=nil; //variabile globale release
    self.filtre=nil;
    self.favorites=nil;
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
    currentSearch = [TSearch alloc];
    globalSettings = [[TSettings alloc]init];
    filtre = [[NSMutableDictionary alloc]init];
    favorites = [[TAdList alloc]init];
    currentLocation = [TLocation alloc];
    statistics = [[TStatisticsList alloc]init];
}

@end
