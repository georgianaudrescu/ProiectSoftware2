//
//  TImageList.m
//  casata
//
//  Created by me on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TImageList.h"
#import "TImage.h"
@implementation TImageList
@synthesize imageList, adId, count;
- (id)init {
    self = [super init];
    if (self) {
        imageList = [[NSMutableOrderedSet alloc]init];
        count=0;
    }
    return self;
}

-(void)getImagesFromData:(NSData *)data forAd:(int)anId
{
    
    self.adId = anId;
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:data
                          options:kNilOptions 
                          error:&error];
    NSLog(@"data JSON: %@", json); 
    NSArray *allImages = [json objectForKey:@"images"];
    
    for(NSDictionary *row in allImages) 
    {
        TImage *image = [TImage alloc];
        [image initWithImageFromUrlString:[row objectForKey:@"url"]];
        image.name = [NSString stringWithString:[row objectForKey:@"name"]];
        image.description = [NSString stringWithString:[row objectForKey:@"description"]];
        NSString *defaultValue = [row objectForKey:@"default"];
        NSString *imageId = [row objectForKey:@"id"];
        image.defaultValue = defaultValue.intValue;
        image.imageId = imageId.intValue;
        
        [imageList addObject:image];
        [image release];
        
    }   
    count = imageList.count;
}
-(void)addImage:(TImage *)image
{   
    [imageList addObject:image];
    count = imageList.count;
}
-(void)removeImage:(TImage *)image
{
    [imageList removeObject:image];
    count = imageList.count;
}

-(TImage *)getImageAtIndex:(int)index
{ 
    return [imageList objectAtIndex:index];
   
}

-(void)removeImageAtIndex:(int)index
{
    [imageList removeObjectAtIndex:index];
    count = imageList.count;
}
-(int)getIndexForImage:(TImage *)image;
{
    return [imageList indexOfObject:image];
}

-(void)dealloc
{  // [imageList release];
    self.imageList = nil;
    [super dealloc];
}@end
