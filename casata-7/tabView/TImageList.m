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
        NSString *defaultValue = [row objectForKey:@"default"];//might be nsnumber
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


-(NSMutableArray*)getArrayOfDictionariesFromImageList
{
    NSMutableArray *mutableArray = [[[NSMutableArray alloc]init]autorelease];
                                
    int x;
    for(x=0;x<count;x++)
    {
        TImage *tempImag=[self getImageAtIndex:x];        
        [mutableArray addObject: [tempImag getDictionaryForImage]];
    }
    return mutableArray;
}

-(void)populateImageListFromArray:(NSArray*)array
{
    for(int x=0;x<array.count;x++)
    {
        NSDictionary *tempDic = [array objectAtIndex:x];
        TImage *img = [TImage alloc];
        [img initWithData: [tempDic objectForKey:@"dataImag"]];
        img.defaultValue = [[tempDic objectForKey:@"default"] intValue];
        img.name = [tempDic objectForKey:@"name"];
        
        NSLog(@"default: %d", img.defaultValue);
        
        [self addImage:img];
        [img release];
        
    }
}

-(int)indexOfDefaultImage
{ 
    for(int x=0;x<count;x++)
    {
        TImage *image = [imageList objectAtIndex:x];
        if(image.defaultValue==1)return x;
    }
    return 0;
}
-(void)dealloc
{  // [imageList release];
    self.imageList = nil;
    [super dealloc];
}
@end
