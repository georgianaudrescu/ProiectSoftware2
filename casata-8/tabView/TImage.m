//
//  TImage.m
//  casata
//
//  Created by me on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TImage.h"

@implementation TImage
@synthesize image,imageId,name,url,description,defaultValue; 

-(void)initWithImageFromUrlString:(NSString *) anURLString
{ 
    self.url = [NSURL URLWithString:anURLString];
       NSData* imageData = [[NSData alloc]initWithContentsOfURL:self.url];
    
    //creeaza view-ul pt imaginea de la url
    self.image = [[UIImage alloc] initWithData:imageData];
    //[imageView setImage:image];
    
  
    [imageData release];
    


}
-(UIImage*) imageWithImage:(UIImage*)anImage scaledToSize:(CGSize)newSize
{
    //pentru a pastra proportiile
    float hfactor = anImage.size.width/newSize.width;
    float vfactor = anImage.size.height/newSize.height;
    float factor = MAX(hfactor, vfactor);
    factor = MAX(factor, 1); //pt a nu redimesniona imagini care sunt deja <
    
    CGSize propotionalSize = CGSizeMake((anImage.size.width/factor), (anImage.size.height/factor));
    
    UIGraphicsBeginImageContext(propotionalSize);
    [anImage drawInRect:CGRectMake(0, 0, propotionalSize.width, propotionalSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//initializarea imageView-ului cu un UIImage(folositor pt image upload, unde pickerul returneaza un UIImage)
-(void) initWithImage:(UIImage *) anImage
{
    self.image = anImage;
    
       
    
    
}
-(UIImage *)theImage
{
    return self.image;
}
-(void)uploadImage:(int)adId
{
    NSURL *aUrl = [NSURL URLWithString:@"http://flapptest.comule.com"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    //setarea requestului si a stringului pt POST
    [request setHTTPMethod:@"POST"];
   
   // NSString *postString = @"left=25%2E96&sessionTime=1325693857685&right=26%2E24&bottom=44%2E33&top=44%2E53&currency=euro&request=get%5Fads&zoom=5000&sid=session1";
   
    //example of stringWithFormat
    //[NSString stringWithFormat:@"%@?app_key=%@&latitude=%f&longitude= %f&limit=%d",kAdsServerURL, appKey, coordinate.latitude, coordinate.longitude, limit];
    
    
    
    
   // [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
   
    
    
    
    NSMutableData *body = [NSMutableData data];
    
    
    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    // file
    NSData *imageData = UIImageJPEGRepresentation(self.image, 90);
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Disposition: attachment; name=\"userfile\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // post string
   NSString *postString = [NSString stringWithFormat:@"request=upload%5image&ad%5id=%d&name=%@&description=%@&default=%d", adId, self.name, self.description, self.defaultValue];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"parameter1\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:postString] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // set request body
    [request setHTTPBody:body];
    
    //return and test
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", returnString);
  
    //urmeaza setarea id-ului dupa prelucrarea stringului primit
   

}
-(NSDictionary *) getDictionaryForImage
{
   // NSData *dataImag =  UIImagePNGRepresentation(self.image);
    NSString *valDefault = [NSString stringWithFormat:@"%d",self.defaultValue];
    NSDictionary *imageDict = [[[NSDictionary alloc] initWithObjectsAndKeys:name,@"name",valDefault,@"default",nil]autorelease]; // dataImag, @"dataImag"
    
    return imageDict;
}
-(void)initWithData:(NSData*)data
{
 self.image = [[UIImage alloc] initWithData:data];
}


-(void) dealloc
{
    
    [image release];
    //
    self.url = nil;
    self.image=nil;
    self.description=nil;
    self.name=nil;
       
    [super dealloc];
}
@end
