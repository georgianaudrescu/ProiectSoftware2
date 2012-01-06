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
}
@property (nonatomic,retain) NSMutableDictionary *ad;

-(void)TAd;
-TAd:(NSDictionary *) row;
-(void) dealloc;

@end
