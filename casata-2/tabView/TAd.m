//
//  TAd.m
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TAd.h"

@implementation TAd

@synthesize ad, imageList, adlocation, request, thumb;//, session;//


-(void)TAd{
    [super init];
}
-(void)TAd:(NSDictionary *)row
{
    //TAd *ad = [TAd alloc];
  //[TAd alloc] initWithId: [row objectForKey:@"id"]; 
    NSNumber *adid = [row objectForKey:@"id"];
    NSNumber * latitude = [ row objectForKey:@"long"];
    NSNumber * longitude = [row objectForKey:@"lat"];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude.doubleValue;
    coordinate.longitude = longitude.doubleValue; 
    NSString * name = [row objectForKey:@"name"];
    NSString * description = [row objectForKey:@"ad_text"];
    NSString * type = [row objectForKey:@"ad_type"];
    NSString * propertyType = [row objectForKey:@"property_type"];
    NSString * contactName = [row objectForKey:@"contact_name"];
    NSString * contactPhone = [row objectForKey:@"contact_phone"];
    NSString * contactEmail = [row objectForKey:@"contact_mail"];
    NSString * address = [row objectForKey:@"adress_line"];
    NSString * judet = [row objectForKey:@"judet"];
    NSString * oras = [row objectForKey:@"oras"];
    NSNumber * price = [row objectForKey:@"pret"];
    NSString * moneda = [row objectForKey:@"moneda"];
  //  NSString *imgurl = [row objectForKey:@"url"];
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
            adid,@"id",
            latitude,@"lat", 
            longitude,@"long",
            name,@"name",
            description,@"ad_text",
            type,@"ad_type",
            propertyType,@"property_type",
            contactName,@"contact_name",
            contactPhone,@"contact_phone",
            contactEmail,@"contact_email",
            address,@"adress_line",
            judet,@"judet",
            oras,@"oras",
            price,@"pret",
            moneda,@"moneda",
          //  previewImage,@"previewImage",
                nil];
 ////   ad = adx;
    self.ad = [NSMutableDictionary alloc];//
    self.ad=adx; //
    //add location implementation
    adlocation =[TLocation alloc];
    //adlocation.coordinate = coordinate;
    [adlocation initWithTitle:name andSubtitle:propertyType andCoord:coordinate]; 

  /*  //add thumbnail
    thumb =[TImage alloc];
    if(imgurl != nil)
    {
        [thumb initWithImageFromUrlString:imgurl];
    }
    else
    {
        [thumb initWithImage:[UIImage imageNamed:@"house.jpg"]];
    }
  */      
    
    //return self.ad;  
}
-(void) UploadImagesttt:(int) ad_id
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
-(void) NewAdWithImageList:(TImageList *)imgLst
{  
    self.imageList = [TImageList alloc];
    self.imageList=imgLst;
    
    request = [TRequest alloc];
    NSString *postString = [NSString stringWithFormat:@"request=add_ad&ad_name=%@&ad_text=%@&adress=%@&coord_x=%@&coord_y=%@&price=%@&currency=%@&ad_type=%@&property_type=%@&judet=%@&oras=%@&size=%@", [self.ad objectForKey:@"name"],[self.ad objectForKey:@"ad_text"],[self.ad objectForKey:@"adress_line"],[self.ad objectForKey:@"long"],[self.ad objectForKey:@"lat"], [self.ad objectForKey:@"pret"], [self.ad objectForKey:@"moneda"], [self.ad objectForKey:@"ad_type"], [self.ad objectForKey:@"property_type"], [self.ad objectForKey:@"judet"], [self.ad objectForKey:@"oras"], [self.ad objectForKey:@"size"]];
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
    
    NSArray *allAds = [json objectForKey:@"ads"];
    NSNumber *idad = [NSNumber alloc];
    for(NSDictionary *row in allAds)
    {
      //  [ad TAd:row];
       NSNumber *idad = [row objectForKey:@"id"];
     //   [session.personalAds addAd:ad];
    }
   // NSNumber *idad = [json objectForKey:@"idad"];
    //recomand NSNumber *idad si dupa trimiti ca parametru idad.intValue
    [self UploadImagesttt:idad.intValue];   
    //[ad release]
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
