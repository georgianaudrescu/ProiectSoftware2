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
    UIImageView *imageView;
    NSString *name;
    NSString *description;
    NSURL *url;
    int imageId;
    
}
@property(nonatomic, assign) int imageId;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *description;
@property(nonatomic,copy) UIImageView *imageView;
@property(nonatomic,copy) NSURL *url;
-(void)initWithImageFromUrlString:(NSString *) anURLString;
-(void) initWithImage:(UIImage *) anImage;
-(UIImageView*)imageView;
@end
