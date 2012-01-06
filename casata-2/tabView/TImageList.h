//
//  TImageList.h
//  casata
//
//  Created by me on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TImageList : NSObject
{
    NSMutableOrderedSet *imageList; 
    
}

@property(nonatomic,copy) NSMutableOrderedSet *imageList;//

-(void)getImagesFromData:(NSData *)data;@end
