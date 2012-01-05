//
//  TLocation.m
//  casata
//
//  Created by me on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TLocation.h"

@implementation TLocation
@synthesize coordinate, description, name, type, locationId;

-(void) dealloc
{
    //[description release];
    //[name release];
    //[type release];
    self.description = nil;
    self.name=nil;
    self.type=nil;
    [super dealloc];

}

@end
