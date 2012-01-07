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
    return self.resultData;
}



@end
