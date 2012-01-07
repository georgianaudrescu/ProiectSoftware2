//
//  TFav.h
//  casata
//
//  Created by me on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLocationList.h"


@interface TFav : NSObject
{
    NSMutableOrderedSet *favAdsList;
    TLocationList *favLocationList;
    NSMutableOrderedSet *favSearchList;
}
@property(nonatomic,copy) NSMutableOrderedSet *favAdsList;
@property(nonatomic,copy)TLocationList *favLocationList;
@property(nonatomic,copy)NSMutableOrderedSet *favSearchList;

@end
