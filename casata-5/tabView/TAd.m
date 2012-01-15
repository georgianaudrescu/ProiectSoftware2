//
//  TAd.m
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TAd.h"

@implementation TAd

@synthesize ad, imageList, adlocation, request,thumb;//, user;//


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
/* //nu avem inca thumbnail de la server, lasa comentat!!!
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
    
    self.imageList = [self GetAdImage:adid.intValue];
*/    
    //return self.ad;  
}
-(void) UploadImagesttt:(int) ad_id withImagelist: (TImageList *) imglist
{
    self.imageList  = imglist;
    
    if(ad_id != 0) 
    {
        for (int i=0; i<imageList.count; i++)
        {
           TImage *img = [imageList getImageAtIndex:i];
           [img uploadImage:(int) ad_id]; 
        }
    } else return;
}

-(id) GetAdImage:(int)ad_id
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