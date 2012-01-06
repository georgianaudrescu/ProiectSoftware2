//
//  TAd.h
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TLocation.h"
#import "TImage.h"
#import "TRequest.h"

@interface TAd : NSObject
{
    NSMutableDictionary *ad;
    NSMutableOrderedSet *imageList;//
    TLocation *adlocation;
    TRequest *request;
    
    
}
@property (nonatomic,retain) NSMutableDictionary *ad;
@property(nonatomic,copy) NSMutableOrderedSet *imageList;//
@property (nonatomic, retain) TLocation *adlocation;
@property (nonatomic, retain) TRequest *request;

-(void)TAd;
-TAd:(NSDictionary *) row;
-(id) GetAdImage:(NSInteger *) ad_id;
-(void) dealloc;

@end
