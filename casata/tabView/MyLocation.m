//
//  MyLocation.m
//  JsonOnMap
//
//  Created by Oana B on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MyLocation.h"


@implementation MyLocation
@synthesize coordinate, title, subtitle;

-(id) initWithTitle:(NSString *)aTitle andSubtitle:(NSString *)aSubtitle{
    self = [super init];
    if (self)
    {
        title = [aTitle copy];
        subtitle = [aSubtitle copy];
    }
    return self;
}


@end
