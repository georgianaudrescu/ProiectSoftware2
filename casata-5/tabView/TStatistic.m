//
//  TStatistic.m
//  casata
//
//  Created by Oana B on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TStatistic.h"
#import "TAvgPrice.h"

@implementation TStatistic
@synthesize avgTotal,avgPriceList;

-(id) init{
    self = [super init];
    if(self) {
        avgPriceList = [[NSMutableOrderedSet alloc]init];
        avgTotal = 0;
    }
    return self;
}


//optiunile selecatate de user in viewController sunt salvate in NSDictionary
-(void) setParamForRequest:(NSDictionary *)paramList{
    startDay = [paramList objectForKey:@"startDay"];
    endDay = [paramList objectForKey:@"endDay"];
    unit = (NSInteger *) [paramList objectForKey:@"unit"];
    adType = (NSInteger *) [paramList objectForKey:@"adType"];//tipului anuntului (1- rent, 2 - sell)
    propType = (NSInteger *) [paramList objectForKey:@"propType"];;//tipului proprietatii (1-“garsoniera”,2-”apartament 2 camere”, 3-”apartament 3 camere”, 4-“apartament 4 camere”,5-”casa”)
    county = [paramList objectForKey:@"county"];
    city  = [paramList objectForKey:@"county"];
}

-(void) parseDataRecieved:(NSData *)data{
    //NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:data
                          options:kNilOptions 
                          error:&error];
    NSArray * allAvgPrice = [json objectForKey:@"avg_price"];
    avgTotal = (double *) [json objectForKey:@"avg_total"];
    
    for(NSDictionary * row in allAvgPrice)
    {
        TAvgPrice *avgPrice = [[TAvgPrice alloc] initWithData:row];
        [avgPriceList addObject:avgPrice];
    }
    [allAvgPrice release];
    [json release];
    [error release];
    
}

-(void) dealloc{
    [avgPriceList dealloc];
    [super dealloc];
    
}

@end
