//
//  TAd.m
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TAd.h"

@implementation TAd

@synthesize ad, imageList, adlocation, request,thumb, uploaded;//, user;//


-(void)TAd{
    [super init];
}
-(void)TAd:(NSDictionary *)row
{
    //TAd *ad = [TAd alloc];
  //[TAd alloc] initWithId: [row objectForKey:@"id"]; 
    NSNumber *adid = [row objectForKey:@"id"];
    NSNumber * latitude = [ row objectForKey:@"lat"];  //era inversat...
    NSNumber * longitude = [row objectForKey:@"long"];  //era inversat...
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude.doubleValue;
    coordinate.longitude = longitude.doubleValue; 
    NSString * name = [row objectForKey:@"name"];
    //NSString * description = [row objectForKey:@"ad_text"];
    NSString * type = [row objectForKey:@"ad_type"];
    NSString * propertyType = [row objectForKey:@"property_type"];
    NSString * contactName = [row objectForKey:@"contact_name"];
    NSString * contactPhone = [row objectForKey:@"contact_phone"];
    NSString * contactEmail = [row objectForKey:@"contact_mail"];
    NSString * address = [row objectForKey:@"address_line"];
    NSString * judet = [row objectForKey:@"judet"];
    NSString * oras = [row objectForKey:@"oras"];
    NSNumber * price = [row objectForKey:@"pret"]; 
    NSString * moneda = [row objectForKey:@"moneda"];
    NSString *size = [row objectForKey:@"size"];
    NSString *imagesNumber = [row objectForKey:@"num_pic"];
   
  
    
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
    self.ad = [NSMutableDictionary dictionaryWithObjectsAndKeys:
            adid,@"id",
            latitude,@"lat", 
            longitude,@"long",
            name,@"name",
            //description,@"ad_text",
            type,@"ad_type",
            propertyType,@"property_type",
            contactName,@"contact_name",
            contactPhone,@"contact_phone",
            contactEmail,@"contact_mail",
            address,@"adress_line",
            judet,@"judet",
            oras,@"oras",
            price,@"pret",
            moneda,@"moneda",
            size , @"size",
            imagesNumber, @"num_pic",   
          //  previewImage,@"previewImage",
                nil];
    /*
 ////   ad = adx;
    self.ad = [NSMutableDictionary alloc];//
    self.ad=adx; //
    //add location implementation
    adlocation =[TLocation alloc];
    //adlocation.coordinate = coordinate;
    [adlocation initWithTitle:name andSubtitle:propertyType andCoord:coordinate]; 
     */
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
-(void)initImageList
{
    imageList = [[TImageList alloc] init];
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


-(NSMutableDictionary *) getDetailsFromAd
{
    return self.ad ;
}
-(void)createAd:(NSDictionary *)row
{
    NSString * latitude = [ row objectForKey:@"lat"];//
    NSString * longitude = [row objectForKey:@"long"];//
    NSString * name = [row objectForKey:@"name"];
    NSString * description = [row objectForKey:@"ad_text"];
    NSString * type = [row objectForKey:@"ad_type"];
    NSString * propertyType = [row objectForKey:@"property_type"];
    NSString * address = [row objectForKey:@"adress_line"];
    NSString * judet = [row objectForKey:@"judet"];
    NSString * oras = [row objectForKey:@"oras"];
    NSString * price = [row objectForKey:@"pret"];
    NSString * moneda = [row objectForKey:@"moneda"];
    NSString * size = [row objectForKey:@"size"];
    NSString * publicat = [row objectForKey:@"publicat"];
    
    NSLog(@"add/edit add with description: %@", description);
    
    self.ad = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               latitude,@"lat", 
               longitude,@"long",
               name,@"name",
               description,@"ad_text",
               type,@"ad_type",
               propertyType,@"property_type",
               address,@"adress_line",
               judet,@"judet",
               oras,@"oras",
               price,@"pret",
               moneda,@"moneda",
               size, @"size",
               publicat, @"publicat",
               nil];
    uploaded = NO;
    
}

-(int)modifyAd:(NSDictionary *)row
{
    int modificat =0;
    NSString * latitude = [ row objectForKey:@"lat"];//
    if(![latitude isEqualToString:[self.ad objectForKey:@"lat"]]){modificat=1;return 1;}
    NSString * longitude = [row objectForKey:@"long"];//
    if(![longitude isEqualToString:[self.ad objectForKey:@"long"]]){modificat=1;return 1;}
    NSString * name = [row objectForKey:@"name"];
    if(![name isEqualToString:[self.ad objectForKey:@"name"]]){modificat=1;return 1;}
    NSString * description = [row objectForKey:@"ad_text"];
    if(![description isEqualToString:[self.ad objectForKey:@"ad_text"]]){modificat=1;return 1;}
    NSString * type = [row objectForKey:@"ad_type"];
    if(![type isEqualToString:[self.ad objectForKey:@"ad_type"]]){modificat=1;return 1;}
    NSString * propertyType = [row objectForKey:@"property_type"];
    if(![propertyType isEqualToString:[self.ad objectForKey:@"property_type"]]){modificat=1;return 1;}
    NSString * address = [row objectForKey:@"adress_line"];
    if(![address isEqualToString:[self.ad objectForKey:@"adress_line"]]){modificat=1;return 1;}
    NSString * judet = [row objectForKey:@"judet"];
    if(![judet isEqualToString:[self.ad objectForKey:@"judet"]]){modificat=1;return 1;}
    NSString * oras = [row objectForKey:@"oras"];
    if(![oras isEqualToString:[self.ad objectForKey:@"oras"]]){modificat=1;return 1;}
    NSString * price = [row objectForKey:@"pret"];
    if(![price isEqualToString:[self.ad objectForKey:@"pret"]]){modificat=1;return 1;}
    NSString * moneda = [row objectForKey:@"moneda"];
    if(![moneda isEqualToString:[self.ad objectForKey:@"moneda"]]){modificat=1;return 1;}
    NSString * size = [row objectForKey:@"size"];
    if(![size isEqualToString:[self.ad objectForKey:@"size"]]){modificat=1;return 1;}
  
   return 0;
    
    // NSString * publicat = [row objectForKey:@"publicat"];
    

}

-(void)thumbnailWithTImage:(TImage*)timage scaledToSize:(CGSize)newSize
{
    //pentru a pastra proportiile
   // float hfactor = timage.image.size.width/newSize.width;
   // float vfactor = timage.image.size.height/newSize.height;
   // float factor = MAX(hfactor, vfactor);
   // factor = MAX(factor, 1); //pt a nu redimesniona imagini care sunt deja <
    
   // CGSize propotionalSize = CGSizeMake((timage.image.size.width/factor), (timage.image.size.height/factor));
    
    UIGraphicsBeginImageContext(newSize);
    [timage.image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
    
    TImage *tempImag =[TImage alloc];
    [tempImag initWithImage:newImage];
    
    
    self.thumb=tempImag;
    
    tempImag=nil;
    //[tempImag release];//
    
}
-(void)readFromMemory:(NSDictionary *)row
{
    //NSLog(@"dict from method (readFromMem):%@",row);

        
    
    
    self.ad = [NSMutableDictionary dictionaryWithDictionary:row];
}

-(void) dealloc{
  [self.ad release];
  [imageList release];//[self.timageList release];    
    
    [super dealloc];
}

@end
