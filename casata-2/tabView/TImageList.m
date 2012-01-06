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
@synthesize imageList;

-(void)getImagesFromData:(NSData *)data
{
    
    imageList = [[NSMutableOrderedSet alloc]init];
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
    
}


-(void)dealloc
{
    self.imageList = nil;
    [super dealloc];
}@end
