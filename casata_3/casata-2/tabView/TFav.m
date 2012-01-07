//
//  TFav.m
//  casata
//
//  Created by me on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFav.h"

@implementation TFav
@synthesize favAdsList, favSearchList,favLocationList;
- (id)init {
    self = [super init];
    if (self) {
        favSearchList= [[NSMutableOrderedSet alloc]init];
        favLocationList=[[NSMutableOrderedSet alloc]init];
        favAdsList=[[NSMutableOrderedSet alloc]init];
    }
    return self;
}
-(void)dealloc
{
    self.favAdsList=nil;
    self.favLocationList =nil;
    self.favSearchList=nil;
    [super dealloc];
}
@end
