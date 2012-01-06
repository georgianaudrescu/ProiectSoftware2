//
//  TAppSession.m
//  casata
//
//  Created by me on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TAppSession.h"

@implementation TAppSession
@synthesize globalAdList,favorites,filtre,currentLocation;  //variabilele globale

-(void)dealloc
{
    self.globalAdList=nil; //variabile globale release
    self.filtre=nil;
    self.favorites=nil;
    self.currentLocation = nil;
    [super dealloc];
}
-(void)globalVariablesInit
{  globalAdList = [[NSMutableOrderedSet alloc]init];
    filtre = [[NSMutableDictionary alloc]init];
    favorites = [[TFav alloc]init];
    currentLocation = [TLocation alloc];
}
@end
