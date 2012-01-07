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

@interface TAppSession : NSObject
{
    //global variables
    NSMutableOrderedSet *globalAdList;
    TFav *favorites;
    NSMutableDictionary *filtre; 
    TLocation *currentLocation;
}
@property(nonatomic, retain) NSMutableOrderedSet *globalAdList;
@property(nonatomic,retain) NSMutableDictionary *filtre;;
@property(nonatomic,retain) TFav *favorites;
@property(nonatomic,retain) TLocation *currentLocation;

//global variables initalization
-(void)globalVariablesInit;

@end
