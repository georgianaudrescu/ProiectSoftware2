//
//  TAd.m
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TAd.h"

@implementation TAd

@synthesize ad, imageList, adlocation, request, thumb;//


-(void)TAd{
    [super init];
}
-(void)TAd:(NSDictionary *)row
{
    //TAd *ad = [TAd alloc];
  //[TAd alloc] initWithId: [row objectForKey:@"id"]; 
    NSNumber *adid = [row objectForKey:@"adid"];
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
    NSString *imgurl = [row objectForKey:@"url"];
   // TImage * previewImage = [row objectForKey:@"previewImage"];
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
            adid,@"adid",
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
          //  previewImage,@"previewImage",
                nil];
    ad = adx;
    
    //add location implementation
    adlocation =[TLocation alloc];
    //adlocation.coordinate = coordinate;
    [adlocation initWithTitle:name andSubtitle:type andCoord:coordinate]; 
    //add thumbnail
    thumb =[TImage alloc];
    if(imgurl != nil)
    {
        [thumb initWithImageFromUrlString:imgurl];
    }
    else
    {
        [thumb initWithImage:[UIImage imageNamed:@"house.jpg"]];
    }
        
    
    //return self.ad;  
}
-(void) UploadImagesttt:(NSInteger *) ad_id
{
    if(ad_id != 0) 
    {
        for (int i=0; i<imageList.count; i++)
        {
           TImage *img = [imageList getImageAtIndex:i];
           [img uploadImage:(int) ad_id]; 
        }
    } else return;
}
-(void) NewAd:(TAd *)newad
{
    request = [TRequest alloc];
    NSString *postString = [NSString stringWithFormat:@"request=newAd&top=%@&bottom=%@&left=%@&right=%@&name=%@&description=%@&property_type=%@&contactName=%@&contactPhone=%@&contactEmail=%@&address=%@&judet=%@&oras=%@&price=%@&moneda=%@&sid=session1", [newad.ad objectForKey:@"adid"],[newad.ad objectForKey:@"latitude"],[newad.ad objectForKey:@"latitude"],[newad.ad objectForKey:@"longitude"],[newad.ad objectForKey:@"longitude"],[newad.ad objectForKey:@"name"], [newad.ad objectForKey:@"description"], [newad.ad objectForKey:@"type"], [newad.ad objectForKey:@"contactName"], [newad.ad objectForKey:@"contactPhone"], [newad.ad objectForKey:@"contactEmail"], [newad.ad objectForKey:@"address"], [newad.ad objectForKey:@"judet"], [newad.ad objectForKey:@"oras"], [newad.ad objectForKey:@"price"],  [newad.ad objectForKey:@"moneda"]];
    NSData * data;
    if([request makeRequestWithString:postString]!=0){
        data=[request requestData];
    }
    
    if ([data length]==0)
    {
        [data release];
        NSLog(@"No data recieved from the server!");
        return;
    }
    NSLog(@"data fetched from server %@",data);
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:data
                          options:kNilOptions 
                          error:&error];
    NSLog(@"data JSON: %@", json); 
    NSInteger *idad = [json objectForKey:@"idad"];
    
    [self UploadImagesttt:idad];    
}

-(id) GetAdImage:(NSInteger *)ad_id
{
    request = [TRequest alloc] ;
    [request initWithHost:@"http://flapptest.comule.com"];
    NSString *postString = [NSString stringWithFormat:@"request=getAdImages&adid=%@&sid=session1", ad_id];
    NSData * data;
    if([request makeRequestWithString:postString]!=0){
        data=[request requestData];
    }
    
    if ([data length]==0)
    {
        [data release];
        NSLog(@"No data recieved from the server!");
        return 0;
    }
    NSLog(@"data fetched from server %@",data);
    imageList = [TImageList alloc];
    [imageList getImagesFromData:data forAd: (int)ad_id];
    return self.imageList;
}
-(void) dealloc{
    [self.ad release];
    [self.imageList release];//    
    [super dealloc];
}

@end
