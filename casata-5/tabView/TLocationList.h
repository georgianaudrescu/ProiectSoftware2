//
//  TLocationList.h
//  casata
//
//  Created by Oana B on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLocation.h"

@interface TLocationList : NSObject
{
    NSMutableOrderedSet *locationList;
    int count;
}

@property (nonatomic, copy) NSMutableOrderedSet *locationList;
@property (nonatomic, assign) int count;

-(id) init;
-(void) addLocation:(TLocation *)aLoc;
-(TLocation*) getLocationFromIndex:(int)index;
-(int) getIndexForLocation:(TLocation *)aLoc;
-(void) removeLocation:(TLocation *)aLoc;
-(void) removeLocationAtIndex:(int)index;


@end
