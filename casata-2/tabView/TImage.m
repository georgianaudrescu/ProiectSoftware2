//
//  TImage.m
//  casata
//
//  Created by me on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TImage.h"

@implementation TImage
@synthesize imageView,imageId,name,url,description; 

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
-(void) dealloc
{
    self.url=nil;
    self.imageView=nil;
    self.description=nil;
    self.name=nil;
    [super dealloc];
}
@end
