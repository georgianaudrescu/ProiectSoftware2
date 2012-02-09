//
//  TAppSession.h
//  casata
//
//  Created by me on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLocation.h"
#import "TAdList.h"
#import "TUser.h"
#import "TSearch.h"
#import "TSettings.h"
#import "TStatisticsList.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


@interface TAppSession : NSObject
{
    //global variables
    TAdList *globalAdList;
    TUser *user;
    TSearch *currentSearch;// not needed
    TSettings *globalSettings;// not needed
    //--TAdList *favorites;
    //TStatisticsList *statistics; // not needed
    NSMutableDictionary *filtre; 
    TLocation *currentLocation;
    TStatistic *stats;
}
@property(nonatomic,retain) TAdList *globalAdList;
@property(nonatomic,retain) TUser *user;
@property(nonatomic,retain) TSearch *currentSearch;
@property(nonatomic,retain) TSettings *globalSettings;
//@property(nonatomic,retain) TStatisticsList *statistics;
@property(nonatomic,retain) NSMutableDictionary *filtre;;
//--@property(nonatomic,retain) TAdList *favorites;
@property(nonatomic,retain) TLocation *currentLocation;
@property(nonatomic,retain) TStatistic *stats;

//global variables initalization
-(void)globalVariablesInit;
-(void)addCurrentSearchResultsToGlobalAdList;
-(NSMutableString*)getStringForFilters;

-(NSDictionary *) getDataForLocalSave;
-(void) saveLocalData;
-(void) readLocalData;

-(NSString *)generateUniqueString;
-(NSString*) getMacAddress;
@end
