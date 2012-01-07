//
//  TSearch.m
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TSearch.h"

@implementation TSearch

@synthesize ad;

-(void) ProcessRequest:(NSMutableDictionary *)filtre2 
              atString:(NSMutableString *) postString 
            withfiltru: (NSString *) filtru andparam:(NSString *) param
{
    if([filtre2 objectForKey:filtru] != nil)
    {
        [postString appendString:[NSString stringWithFormat:param, [filtre2 objectForKey:filtru]]]; 
    }
}

-(void) Search:(NSMutableDictionary *) filtre
{
    TRequest * myRequest = [TRequest alloc] ;    
    [myRequest initWithHost:@"http://flapptest.comule.com"];
    NSMutableString *postString = [NSMutableString string];
    postString =[NSString stringWithFormat:@"left=%@&right=%@&bottom=%@&top=%@&request=get%5Fads&zoom=5000&sid=session1$sessionTime=1325954282097",[filtre objectForKey:@"latitude"],[filtre objectForKey:@"latitude"], [filtre objectForKey:@"longitude"],[filtre objectForKey:@"longitude"]] ;
    if([filtre objectForKey:@"ad_type"] != nil)
    {
        [postString appendString:[NSString stringWithFormat:@"&type=%@", [filtre objectForKey:@"ad_type"]]]; 
    }
    if([filtre objectForKey:@"prop_type"] != nil)
    {
        [postString appendString:[NSString stringWithFormat:@"&property%5Ftype=%@", [filtre objectForKey:@"prop_type"]]]; 
    }
    [self ProcessRequest:filtre atString:postString withfiltru:@"min" andparam:@"&min=%@"];
    [self ProcessRequest:filtre atString:postString withfiltru:@"min_size" andparam:@"&min%5Fsize=%@"];
    [self ProcessRequest:filtre atString:postString withfiltru:@"max" andparam:@"&max=%@"];
    [self ProcessRequest:filtre atString:postString withfiltru:@"max_size" andparam:@"&max%5Fsize=%@"];
    [self ProcessRequest:filtre atString:postString withfiltru:@"currency" andparam:@"&currency=%@"];
    [self ProcessRequest:filtre atString:postString withfiltru:@"order_by" andparam:@"&order%5Fby=%@"];
    
    NSData * data;
    if([myRequest makeRequestWithString:postString]!=0){
        data=[myRequest requestData];
    }
    
    if ([data length]==0)
    {
        [data release];
        NSLog(@"No data recieved from the server!");
        return;
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
    for(NSDictionary *row in allAds)
    {
        [ad TAd:row];
    }
 
}
@end
