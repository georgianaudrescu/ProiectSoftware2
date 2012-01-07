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



-(void)dealloc
{
    self.adList = nil;
    self.request=nil;
    [super dealloc];
}

@end