//
//  TSearch.m
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TSearch.h"

@implementation TSearch

@synthesize ad, listAds;

-(void) ProcessRequest:(NSMutableDictionary *)filtre2 
              atString:(NSMutableString *) postString 
            withfiltru: (NSString *) filtru andparam:(NSString *) param
{
    if([filtre2 objectForKey:filtru] != nil)
    {
        [postString appendString:[NSString stringWithFormat:param, [filtre2 objectForKey:filtru]]]; 
    }
}

-(TAdList *) Search:(NSMutableDictionary *) filtre
{
    TRequest * myRequest = [TRequest alloc] ;    
    [myRequest initWithHost:@"http://flapptest.comule.com"];
    NSMutableString *postString = [NSMutableString string];
    postString =[NSString stringWithFormat:@"left=%@&right=%@&bottom=%@&top=%@&request=get%5Fads&zoom=5000&sessionTime=1325954282097",[filtre objectForKey:@"latitude"],[filtre objectForKey:@"latitude"], [filtre objectForKey:@"longitude"],[filtre objectForKey:@"longitude"]] ;
    if([filtre objectForKey:@"ad_type"] != nil)
    {
        [postString appendString:[NSString stringWithFormat:@"&type=%@", [filtre objectForKey:@"ad_type"]]]; 
    }
    if([filtre objectForKey:@"prop_type"] != nil)
    {
        [postString appendString:[NSString stringWithFormat:@"&property%5Ftype=%@", [filtre objectForKey:@"prop_type"]]]; 
    }
    [self ProcessRequest:filtre atString:postString withfiltru:@"order_by" andparam:@"&order%5Fby=%@"];
    [self ProcessRequest:filtre atString:postString withfiltru:@"p_min" andparam:@"&p%5Fmin=%@"];
    [self ProcessRequest:filtre atString:postString withfiltru:@"p_max" andparam:@"&p%5Fmax=%@"];
    [self ProcessRequest:filtre atString:postString withfiltru:@"currency" andparam:@"&currency=%@"];
    [self ProcessRequest:filtre atString:postString withfiltru:@"rating_min" andparam:@"&rating%5Fmin=%@"];
    [self ProcessRequest:filtre atString:postString withfiltru:@"rating_max" andparam:@"&rating%5Fmax=%@"];
    [self ProcessRequest:filtre atString:postString withfiltru:@"size_min" andparam:@"&size%5Fmin=%@"];
    [self ProcessRequest:filtre atString:postString withfiltru:@"size_max" andparam:@"&size%5Fmax=%@"];
    
    
    
    NSData * data;
    if([myRequest makeRequestWithString:postString]!=0){
        data=[myRequest requestData];
    }
    
    if ([data length]==0)
    {
        [data release];
        NSLog(@"No data recieved from the server!");
        return nil;
    }
    NSLog(@"data fetched from server %@",data);
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:data
                          options:kNilOptions 
                          error:&error];
    NSLog(@"data JSON: %@", json); 
    NSArray *allAds = [json objectForKey:@"ads"];
    listAds = [TAdList alloc];
    for(NSDictionary *row in allAds)
    {
        [ad TAd:row];
        [listAds addAd:ad];
    }
    return listAds;
}
@end
