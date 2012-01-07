//
//  TLocationList.m
//  casata
//
//  Created by Oana B on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TLocationList.h"
#import "TLocation.h"


@implementation TLocationList
@synthesize locationList, count;

-(id) init{
    self = [super init];
    if(self) {
        locationList = [[NSMutableOrderedSet alloc]init];
    }
    return self;
}

- (void) addLocation:(TLocation *)aLocation{
    [locationList addObject:aLocation];
    count=locationList.count;
}

- (TLocation*)getLocationFromIndex:(int)index {
    
    return [locationList objectAtIndex:index];
}

- (int) getIndexForLocation:(TLocation *)aLocation{
    return [locationList indexOfObject:aLocation];
}

- (void) removeLocation:(TLocation *)aLoc{
    [locationList removeObject:aLoc];
    count = locationList.count;
}

-(void) removeLocationAtIndex:(int)index{
    [locationList removeObjectAtIndex:index];
    count= locationList.count;
}


-(void) dealloc
{
    [self.locationList dealloc];
    [super dealloc];
}

@end
