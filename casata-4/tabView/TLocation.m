//
//  MyLocation.m
//  JsonOnMap
//
//  Created by Oana B on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TLocation.h"


@implementation TLocation
@synthesize coordinate, title, subtitle, locationId;
@synthesize adresa, pret, tipAnunt, tipProprietate;

-(id) initWithTitle:(NSString *)aTitle andSubtitle:(NSString *)aSubtitle andCoord:(CLLocationCoordinate2D)aCoord{
    self = [super init];
    if (self)
    {
        title = [aTitle copy];
        subtitle = [aSubtitle copy];
        coordinate = aCoord;
        //locationId = ??
    }
    return self;
}

-(void) dealloc
{
    [self.title dealloc];
    [self.subtitle dealloc];
    
    [adresa release];
    [pret release];
    [tipAnunt release];
    [tipProprietate release];
    [super dealloc];
}

@end
