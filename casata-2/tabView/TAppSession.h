//
//  TAppSession.h
//  casata
//
//  Created by me on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFav.h"
#import "TLocation.h"
#import "TAdList.h"
#import "TUser.h"
#import "TSearch.h"
#import "TSettings.h"
#import "TStatisticsList.h"

@interface TAppSession : NSObject
{
    //global variables
    TAdList *globalAdList;
    TUser *user;
    TSearch *currentSearch;
    TSettings *globalSettings;
    TFav *favorites;
    TStatisticsList *statistics;
    NSMutableDictionary *filtre; 
    TLocation *currentLocation;
}
@property(nonatomic, retain) TAdList *globalAdList;
@property(nonatomic,retain) TUser *user;
@property(nonatomic,retain) TSearch *currentSearch;
@property(nonatomic,retain) TSettings *globalSettings;
@property(nonatomic,retain) TStatisticsList *statistics;
@property(nonatomic,retain) NSMutableDictionary *filtre;;
@property(nonatomic,retain) TFav *favorites;
@property(nonatomic,retain) TLocation *currentLocation;

//global variables initalization
-(void)globalVariablesInit;
-(void)addCurrentSearchResultsToGlobalAdList;
@end
