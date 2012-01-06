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
//#import "TLocation.h"
#import "TImage.h"

@interface TAd : NSObject
{
    NSMutableDictionary *ad;
    NSMutableOrderedSet *imageList;//
}
@property (nonatomic,retain) NSMutableDictionary *ad;
@property(nonatomic,copy) NSMutableOrderedSet *imageList;//
-(void)TAd;
-TAd:(NSDictionary *) row;
-(void) dealloc;

@end
