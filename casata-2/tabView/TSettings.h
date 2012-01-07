//
//  TSettings.h
//  casata
//
//  Created by Oana B on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSettings : NSObject
{
    NSString *syncType;
    NSString *syncTime;
    NSString *syncPriority;
    NSString *syncPersonalAds;
    BOOL keepExpAds;
}

@property (nonatomic, copy)  NSString *syncType;
@property (nonatomic, copy) NSString *syncTime;
@property (nonatomic, copy) NSString *syncPriority;
@property (nonatomic, copy) NSString *syncPersonalAds;

- (id) init;
- (void) loadSettings;
- (void) saveSettings;

@end
