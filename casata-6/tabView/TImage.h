//
//  TImage.h
//  casata
//
//  Created by me on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TImage : NSObject
{
    UIImage *image; //change from UIImageView to UIImage
    NSString *name;
    NSString *description;
    NSURL *url;
    int imageId;
    int defaultValue;
}
@property(nonatomic, assign) int imageId;
@property(nonatomic, assign) int defaultValue;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *description;
@property(nonatomic,copy) UIImage *image;
@property(nonatomic,copy) NSURL *url;

-(void)initWithImageFromUrlString:(NSString *) anURLString;
-(void) initWithImage:(UIImage *) anImage;
-(UIImage*)theImage;
-(void)uploadImage:(int)adId;


-(NSDictionary *) getDictionaryForImage;

@end
