//
//  TAd.m
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TAd.h"

@implementation TAd

@synthesize ad, imageList;//


-(void)TAd{
    [super init];
}
-(id)TAd:(NSDictionary *)row
{
    //TAd *ad = [TAd alloc];
  //[TAd alloc] initWithId: [row objectForKey:@"id"]; 
   // NSInteger *adid = [row objectForKey:@"id"];
    NSNumber * latitude = [ row objectForKey:@"long"];
    NSNumber * longitude = [row objectForKey:@"lat"];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude.doubleValue;
    coordinate.longitude = longitude.doubleValue; 
    NSString * name = [row objectForKey:@"name"];
    NSString * description = [row objectForKey:@"description"];
    NSString * type = [row objectForKey:@"type"];
    NSString * contactName = [row objectForKey:@"contactName"];
    NSString * contactPhone = [row objectForKey:@"contactPhone"];
    NSString * contactEmail = [row objectForKey:@"contactEmail"];
    NSString * address = [row objectForKey:@"address"];
    NSString * judet = [row objectForKey:@"judet"];
    NSString * oras = [row objectForKey:@"oras"];
    NSNumber * price = [row objectForKey:@"price"];
    NSString * moneda = [row objectForKey:@"moneda"];
  //  TImage * previewImage = [row objectForKey:@"previewImage"];
    /*  Id          int
     coordinate     TLocation
     name           string
     description	string
     type           string
     contactName	string
     contactPhone	string
     contactEmail	
     adress         string
     judet          string
     oras	
     price          int
     moneda	
     previewImage	TImage */
    NSMutableDictionary *adx = [NSMutableDictionary dictionaryWithObjectsAndKeys:
            latitude,@"coordinate.latitude", 
            longitude,@"coordinate.longitude",
            name,@"name",
            description,@"description",
            type,@"type",
            contactName,@"contactName",
            contactPhone,@"contactPhone",
            contactEmail,@"contactEmail",
            address,@"address",
            judet,@"judet",
            oras,@"oras",
            price,@"price",
            moneda,@"moneda",
                nil];
    ad = adx;
    
    imageList = [[NSMutableOrderedSet alloc]init];//
    
    return self.ad;  
}

-(void) dealloc{
    [self.ad release];
    [self.imageList release];//
    [super dealloc];
}

@end
