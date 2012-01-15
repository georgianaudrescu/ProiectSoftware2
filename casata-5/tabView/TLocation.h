//
//  MyLocation.h
//  JsonOnMap
//
//  Created by Oana B on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TLocation : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
    int locationId;
    ///
    NSString *adresa;
    NSString *pret;
    NSString *tipAnunt;
    NSString *tipProprietate;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic, assign) int locationId;
@property(nonatomic, copy) NSString *adresa, *pret, *tipAnunt, *tipProprietate;

- (id)initWithTitle:(NSString *)aTitle andSubtitle:(NSString *)aSubtitle andCoord:(CLLocationCoordinate2D)aCoord;

@end