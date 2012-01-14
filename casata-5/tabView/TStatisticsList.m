//
//  TStatisticsList.m
//  casata
//
//  Created by Oana B on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TStatisticsList.h"

@implementation TStatisticsList
@synthesize statsList;

-(id)init{
    self=[super init];
    if(self)
    {
        statsList = [[NSMutableOrderedSet alloc]init];
    }
    return self;
}

-(void)addStatistic:(TStatistic *)aStat
{
    [statsList addObject:aStat];
    count = statsList.count;
}

-(TStatistic*) getStatisticFromIndex:(int)index{
    return [statsList objectAtIndex:index];
}

-(int) getIndexForStatistic:(TStatistic *)aStat{
    return [statsList indexOfObject:aStat];
}

-(void) removeStatistic:(TStatistic *)aStat{
    [statsList removeObject:aStat];
}

-(void) removeStatisticAtIndex:(int)index{
    [statsList removeObjectAtIndex:index];
}

-(void) dealloc{
    [statsList dealloc];
    [super dealloc];
}

@end
