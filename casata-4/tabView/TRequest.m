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
        return 0;
    }
    return 1;
}

-(NSData *)requestData{
    
    //remove track
    NSString *string = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    NSArray *arr =[string componentsSeparatedByString:@"<!--"];
    resultData=[[arr objectAtIndex:0] dataUsingEncoding: [NSString defaultCStringEncoding] ];
    
    
    return self.resultData;
}

-(void) dealloc{
    [super dealloc];
}



@end
