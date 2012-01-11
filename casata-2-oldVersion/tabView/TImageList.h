//
//  TImageList.h
//  casata
//
//  Created by me on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TImage.h"

@interface TImageList : NSObject
{
    NSMutableOrderedSet *imageList; 
    int count;
   int adId;
}

@property(nonatomic,copy) NSMutableOrderedSet *imageList;//
@property(nonatomic, assign) int count;
@property(nonatomic, assign) int adId;


-(void)getImagesFromData:(NSData *)data forAd:(int)anId;

-(void)addImage:(TImage *)image;//
-(void)removeImage:(TImage *)image;//
-(TImage *)getImageAtIndex:(int)index;//
-(void)removeImageAtIndex:(int)index;//
-(int)getIndexForImage:(TImage *)image;//
@end
