//
//  TAd.h
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TLocation.h"
#import "TImage.h"
#import "TRequest.h"
#import "TImageList.h"
#import "TUser.h"

@interface TAd : NSObject
{
    NSMutableDictionary *ad;
    TImageList *imageList;//
    TLocation *adlocation;
    TRequest *request;   
    TImage *thumb;
    TUser *session;
    
}
@property (nonatomic,retain) NSMutableDictionary *ad;
@property(nonatomic,copy) TImageList *imageList;//
@property (nonatomic, retain) TLocation *adlocation;
@property (nonatomic, retain) TRequest *request;
@property (nonatomic, retain) TImage *thumb;
@property (nonatomic, retain) TUser *session;

-(void)TAd;
-(void)TAd:(NSDictionary *) row;
-(id) GetAdImage:(NSInteger *) ad_id;
-(void) UploadImagesttt:(int) ad_id;
-(void) NewAdWithImageList:(TImageList *)imgLst;
-(void) dealloc;

@end
