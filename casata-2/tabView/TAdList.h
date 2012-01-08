//
//  TAdList.h
//  casata
//
//  Created by me on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#if !defined(TADLIST)
#define TADLIST 1

#import <Foundation/Foundation.h>
#import "TRequest.h"
#import "TAd.h"

@interface TAdList : NSObject
{
    NSMutableOrderedSet *adList; 
    int count;
    TRequest *request;
    
}
@property(nonatomic,copy) NSMutableOrderedSet *adList;//
@property(nonatomic, assign) int count;
@property(nonatomic,retain) TRequest *request;


-(void)addAd:(TAd *)ad;//
-(void)removeAd:(TAd *)ad;//
-(TAd *)getAdAtIndex:(int)index;//
-(void)removeAdAtIndex:(int)index;//
-(int)getIndexForAd:(TAd *)ad;//
-(void)populateListWithRequest:(TRequest *)aRequest;
-(TAd *)getAdWithId:(int)index;

@end

#endif //TADLIST
