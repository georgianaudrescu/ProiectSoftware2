//
//  TSettings.h
//  casata
//
//  Created by Diana on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSettings : NSObject
{
    
    int synchronizeOption;
    NSString *saveOptions;
    int keepExpiredAds;
}

@property(nonatomic, copy) NSString *saveOptions;
@property(nonatomic,assign) int synchronizeOptions;
@property(nonatomic,assign) int keepExpiredAds;
@end
