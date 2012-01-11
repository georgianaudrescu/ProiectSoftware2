//
//  TImage.m
//  casata
//
//  Created by me on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TImage.h"

@implementation TImage
@synthesize imageView,imageId,name,url,description,defaultValue; 

-(void)initWithImageFromUrlString:(NSString *) anURLString
{ 
    self.url = [NSURL URLWithString:anURLString];
       NSData* imageData = [[NSData alloc]initWithContentsOfURL:self.url];
    
    //creeaza view-ul pt imaginea de la url
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    //[imageView setImage:image];
    imageView = [[UIImageView alloc] initWithImage:image];
  
    [imageData release];
    [image release];    


}

//initializarea imageView-ului cu un UIImage(folositor pt image upload, unde pickerul returneaza un UIImage)
-(void) initWithImage:(UIImage *) anImage
{
    imageView = [[UIImageView alloc] initWithImage:anImage];
    
       
    
    
}
-(UIImageView *)theImageView
{
    return self.imageView;
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
    NSData *imageData = UIImageJPEGRepresentation(imageView.image, 90);
    
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



-(void) dealloc
{
    
    self.url = nil;
    self.imageView=nil;
    self.description=nil;
    self.name=nil;
       
    [super dealloc];
}
@end
