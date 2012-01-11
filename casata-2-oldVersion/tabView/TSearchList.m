//
//  TSearchList.m
//  casata
//
//  Created by me on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TSearchList.h"


@implementation TSearchList
@synthesize searchList, count;
- (id)init {
    self = [super init];
    if (self) {
        searchList = [[NSMutableOrderedSet alloc]init];
        count=0;
    }
    return self;
}


-(void)addSearch:(TSearch *)search
{   
    [searchList addObject:search];
    count = searchList.count;
}
-(void)removeSearch:(TSearch *)search
{
    [searchList removeObject:search];
    count = searchList.count;
}

-(TSearch *)getSearchAtIndex:(int)index
{ 
    return [searchList objectAtIndex:index];
    
}

-(void)removeSearchAtIndex:(int)index
{
    [searchList removeObjectAtIndex:index];
    count = searchList.count;
}
-(int)getIndexForSearch:(TSearch *)search
{
    return [searchList indexOfObject:search];
}

-(void)dealloc
{  // [searchList release];
    self.searchList = nil;
    [super dealloc];
}
@end
