//
//  TAd.h
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#if !defined(TAD)
#define TAD 1

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TLocation.h"
#import "TImage.h"
#import "TRequest.h"
#import "TImageList.h"
//#import "TUser.h"

@interface TAd : NSObject
{
    NSMutableDictionary *ad;
    TImageList *imageList;//
    TLocation *adlocation;
    TRequest *request;   
    TImage *thumb;
 //   TUser *user;
    
}
@property (nonatomic,retain) NSMutableDictionary *ad;
@property(nonatomic,copy) TImageList *imageList;//
@property (nonatomic, retain) TLocation *adlocation;
@property (nonatomic, retain) TRequest *request;
@property (nonatomic, retain) TImage *thumb;
//@property (nonatomic, retain) TUser *user;

-(void)TAd;
-(void)TAd:(NSDictionary *) row;
-(id) GetAdImage:(int) ad_id;
-(void) UploadImagesttt:(int) ad_id withImagelist: (TImageList *) imglist;
-(void)initImageList;
-(void) dealloc;

@end

#endif //TAD
