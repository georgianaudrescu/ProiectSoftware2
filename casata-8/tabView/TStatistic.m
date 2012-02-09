//
//  TStatistic.m
//  casata
//
//  Created by Oana B on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TStatistic.h"
#import "TAvgPrice.h"
#import "TRequest.h"

@implementation TStatistic
//@synthesize avgTotal,avgPriceList;
@synthesize statsReq, generalAvg, filterAvg, generalAvgTotal, generalDif, prevGeneralAvgTotal,filterAvgTotal, filterDif, prevFilterAvgTotal,status;

-(id) init 
{
    self = [super init];
    if (self) {
        statsReq = [TRequest alloc];
        [statsReq initWithHost:@"http://unicode.ro/imobiliare/index.php"];
        status = @"";
    }
    return self;
}


-(int) parseDataRecieved:(NSData *)data
{
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:data
                          options:kNilOptions 
                          error:&error];
    NSLog(@"data JSON: %@", json); 
    
    status = [json objectForKey:@"status"];
    if([status isEqualToString:@"OK"])
    {
    self.generalAvg = [json objectForKey:@"general_avg_day"];
    self.prevGeneralAvgTotal = [json objectForKey:@"prev_general_avg_total"];
    self.generalAvgTotal = [json objectForKey:@"general_avg_total"];
    self.generalDif = [json objectForKey:@"general_avg_diff"];
    
    self.filterAvg = [json objectForKey:@"filter_avg_day"];
    self.prevFilterAvgTotal = [json objectForKey:@"prev_filter_avg_total"];
    self.filterAvgTotal = [json objectForKey:@"filter_avg_total"];
    self.filterDif = [json objectForKey:@"filter_avg_diff"];
        //NSLog(@"generalAvg=%@, prevGenAvg=%f, genTotal=%f, generalDiff=%f,filterAvg=%@, prevFilterAvg=%f, filterTotal=%f, filterDiff=%f", self.generalAvg, [self.prevGeneralAvgTotal doubleValue], [self.generalAvgTotal doubleValue], [self.generalDif doubleValue], self.filterAvg, [self.prevFilterAvgTotal doubleValue], [self.filterAvgTotal doubleValue], [self.filterDif doubleValue]);
    if([generalAvg count]==0)  {return 0;}
        return 1;
    }
    else 
    {
        NSLog(@"EROARE LA STATISTICI: %@",[json objectForKey:@"desc"]);
        return 0;
    }
    return 0;
    
}



/*
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
 */

-(void) dealloc{

    [statsReq release];
    [prevGeneralAvgTotal release];
    [prevFilterAvgTotal release];
    [generalAvgTotal release];
    [filterAvgTotal release];
    [generalDif release];
    [filterDif release];
    [generalAvg release];
    [filterAvg release];
    [status release];
    [super dealloc];
    
}

@end
