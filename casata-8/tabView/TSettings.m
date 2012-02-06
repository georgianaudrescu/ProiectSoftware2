//
//  TSettings.m
//  casata
//
//  Created by Oana B on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TSettings.h"

@implementation TSettings
@synthesize syncType, syncTime, syncPriority,syncPersonalAds;

- (id)init{
    self = [super init];
    if (self)
    {
        syncType = @"default";
        syncTime = @"default";
        syncPriority =@"default";
        syncPersonalAds=@"default";
        keepExpAds=1;
    }
    return self;
}

- (void) saveSettings{
    //save settings in memory
}

- (void) loadSettings{
    //load settings from memory
}

-(void) dealloc{
    [super dealloc];
}

@end
