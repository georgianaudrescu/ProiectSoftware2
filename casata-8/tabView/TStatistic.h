//
//  TStatistic.h
//  casata
//
//  Created by Oana B on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRequest.h"

@interface TStatistic : NSObject{
    TRequest *statsReq;
    NSArray * generalAvg;
    NSArray * filterAvg;
    
    NSNumber * prevGeneralAvgTotal;
    NSNumber * generalAvgTotal;
    NSNumber * generalDif;
    
    NSNumber * prevFilterAvgTotal;
    NSNumber * filterAvgTotal;
    NSNumber * filterDif;
    
    NSString * status;
    
    /*
    NSDate *startDay;
    NSDate *endDay;
    NSInteger *unit;
    NSInteger *adType;//tipului anuntului (1- rent, 2 - sell)
    NSInteger *propType;//tipului proprietatii (1-“garsoniera”,2-”apartament 2 camere”, 3-”apartament 3 camere”, 4-“apartament 4 camere”,5-”casa”)
    NSString *county;
    NSString *city;
    
    NSMutableOrderedSet *avgPriceList;
    double *avgTotal;
     */
}
/*
@property (nonatomic, readonly) double *avgTotal;
@property (nonatomic, copy)NSMutableOrderedSet *avgPriceList;
 */
@property (nonatomic, retain)  TRequest *statsReq;
@property (nonatomic, retain) NSArray * generalAvg, * filterAvg;
@property (nonatomic, retain) NSNumber * prevGeneralAvgTotal,* generalAvgTotal, * generalDif,* prevFilterAvgTotal, * filterAvgTotal,* filterDif;
@property (nonatomic, retain) NSString * status;


-(id) init;
//-(void)setParamForRequest:(NSDictionary *) paramList; 
-(int)parseDataRecieved:(NSData *) data;

@end
