//
//  TRequest.m
//  casata
//
//  Created by Oana B on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TRequest.h"

@implementation TRequest
@synthesize resultData, url;
@synthesize paramList;

-(void)initWithHost:(NSString *)hostString{
    self.url = [NSURL URLWithString:hostString];
}

-(BOOL)makeRequestWithString:(NSString *)postString{
    NSLog(@"sa vedem aici: %@",self);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    ///
    ///setarea requestului si a stringului pt POST
    ///
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLResponse *response;
    
    ///
    ///primirea raspunsului
    ///
    self.resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if ([self.resultData length]==0){
        NSLog(@"No data received!");
        //NSLog(@"pe return 0: %@",self);
        return 0;
    }
    //NSLog(@"data received on connection! %@", resultData);
    NSLog(@"am primit datele de la server!");
    return 1;
}

-(NSData *)requestData{
    
    //remove track
    //NSString *string = [[[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding]autorelease];
    //NSLog(@"All the data received in NSString format: %@",string );
    //NSArray *arr =[string componentsSeparatedByString:@"<!--"];
    //resultData=[[arr objectAtIndex:0] dataUsingEncoding: [NSString defaultCStringEncoding] ];
    
    
    return self.resultData;
}


-(NSDictionary *) responseDictionaryOfRequest{

    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:resultData
                          options:kNilOptions 
                          error:&error];
    return json;
}

-(void) dealloc{
    [super dealloc];
}



@end
