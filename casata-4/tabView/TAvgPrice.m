//
//  TAvgPrice.m
//  casata
//
//  Created by Oana B on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TAvgPrice.h"

@implementation TAvgPrice
@synthesize date;

- (id) init{
    self=[super init];
    // initialization
    return self;
}

-(id) initWithData:(NSDictionary *)data{
    for(NSDictionary *row in data)
    {
        pos = (NSInteger *) [row objectForKey:@"pos"];
        price = (NSInteger *) [row objectForKey:@"price"];
        date = [row objectForKey:@"date"];
    }
    return self;
}

-(void) dealloc{
    [super dealloc];
}


@end
