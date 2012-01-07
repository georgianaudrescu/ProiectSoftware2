//
//  TAdList.h
//  casata
//
//  Created by Diana on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRequest.h"
#import "TAd.h"
@interface TAdList : NSObject
{
    NSMutableOrderedSet *adList; 
    TRequest *getAdListRequest;
    int countAdsInAdList; 
    
    
}


@property(nonatomic,copy) NSMutableOrderedSet *adList;//
@property(nonatomic,copy) TRequest *getAdListRequest;
@property(nonatomic,assign) int countAdsInAdList;


-(id)init;
-(void) addAdToAdList:(TAd *) aAdL;
-(TAd *) getAdFromIndex: (int) indexAdList;
-(int) getIndexForAd:(TAd *) aAdL;
-(void) removeAdFromAdList:(TAd * )aAdL;
-(void) removeAdAtIndex:(int)indexAdList;

-(void)getAdsFromData:(NSData *)data;//load from file
//-(void)DeleteAdd;
//-(void)DEleteIndex;
//-(void)removeIndex;
//-(void)savetohdd;
@end


