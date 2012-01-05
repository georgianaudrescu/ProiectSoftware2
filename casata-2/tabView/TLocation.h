//
//  TLocation.h
//  casata
//
//  Created by me on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface TLocation : NSObject
{
    CLLocationCoordinate2D coordinate;
    NSString *name;
    int locationId;
    NSString *description;
    NSString *type;
    
}
@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *description;
@property(nonatomic,retain) NSString *type;
@property(nonatomic,assign)int locationId;

@end
