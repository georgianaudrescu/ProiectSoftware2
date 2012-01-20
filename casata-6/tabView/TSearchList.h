//
//  TSearchList.h
//  casata
//
//  Created by me on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSearch.h"

@interface TSearchList : NSObject
{
    NSMutableOrderedSet *searchList; 
    int count;
    
}

@property(nonatomic,copy) NSMutableOrderedSet *searchList;//
@property(nonatomic, assign) int count;




-(void)addSearch:(TSearch *)search;//
-(void)removeSearch:(TSearch *)search;//
-(TSearch *)getSearchAtIndex:(int)index;//
-(void)removeSearchAtIndex:(int)index;//
-(int)getIndexForSearch:(TSearch *)search;//
@end
