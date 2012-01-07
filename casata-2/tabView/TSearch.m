//
//  TSearch.m
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TSearch.h"

@implementation TSearch
-(void) Search:(NSArray *) filtre
{
    TRequest * myRequest = [TRequest alloc] ;
    [myRequest initWithHost:@"http://flapptest.comule.com"];
    NSString *postString = @"left=25%2E96&sessionTime=1325693857685&right=26%2E24&bottom=44%2E33&top=44%2E53&currency=euro&request=get%5Fads&zoom=5000&sid=session1";
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
 
}

/*


NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
NSArray *arr =[string componentsSeparatedByString:@"<!--"];
NSLog(@"Array %@:",[arr objectAtIndex:0]);
data=[[arr objectAtIndex:0] dataUsingEncoding: [NSString defaultCStringEncoding] ];

self.view.hidden = NO;
//parse out the json data
NSError* error;
NSDictionary* json = [NSJSONSerialization 
                      JSONObjectWithData:data
                      options:kNilOptions 
                      error:&error];
NSLog(@"data JSON: %@", json); 
NSArray *allAds = [json objectForKey:@"ads"];*/
@end
