//
//  TFav.h
//  casata
//
//  Created by me on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFav : NSObject
{
    NSMutableOrderedSet *favAdsList;
    NSMutableOrderedSet *favLocationList;
    NSMutableOrderedSet *favSearchList;
}
@property(nonatomic,copy) NSMutableOrderedSet *favAdsList;
@property(nonatomic,copy)NSMutableOrderedSet *favLocationList;
@property(nonatomic,copy)NSMutableOrderedSet *favSearchList;

@end
