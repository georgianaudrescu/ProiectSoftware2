//
//  TAvgPrice.h
//  casata
//
//  Created by Oana B on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAvgPrice : NSObject{
    NSInteger * pos;
    NSInteger * price;
    NSDate * date;
}


@property (nonatomic, copy) NSDate * date;

- (id) init;
- (id) initWithData:(NSDictionary *)data;

@end
