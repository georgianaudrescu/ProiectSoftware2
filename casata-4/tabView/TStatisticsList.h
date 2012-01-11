//
//  TStatisticsList.h
//  casata
//
//  Created by Oana B on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TStatistic.h"

@interface TStatisticsList : NSObject{
    NSMutableOrderedSet *statsList;
    int count;
}
@property (nonatomic, copy) NSMutableOrderedSet *statsList;

-(id) init;
-(void) addStatistic:(TStatistic *) aStat;
-(TStatistic*) getStatisticFromIndex:(int)index;
-(int) getIndexForStatistic:(TStatistic *)aStat;
-(void) removeStatistic:(TStatistic *)aStat;
-(void) removeStatisticAtIndex:(int)index;

@end
