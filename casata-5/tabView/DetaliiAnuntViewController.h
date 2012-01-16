//
//  DetaliiAnuntViewController.h
//  casata
//
//  Created by me on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TAd.h"
#import "TImageList.h"
@interface DetaliiAnuntViewController : UIViewController
{
    //int ad_id;
    TAd *theAd;
    AppDelegate *apdelegate;
    UILabel *nameLabel;
    UILabel *propertyTypeLabel, *anuntTypeLabel;
    UILabel *adTextlabel;
    UILabel *adressLineLabel;
    UILabel *pretLabel;
    UILabel *monedaLabel;
    UILabel *contactNameLabel;
    UILabel *contactPhoneLabel;
    UIImageView *thumbnailImageView;
    //
    UIScrollView *imgScrollView;
    UIImageView *imgView;
    NSMutableArray *buttonsArray;
    TImageList *imgList;
}
@property(nonatomic,retain) TAd *theAd;
@property(nonatomic,retain) IBOutlet UILabel *nameLabel,*propertyTypeLabel, *adTextLabel, *adressLineLabel, *pretLabel, *monedaLabel, *contactNameLabel, *contactPhoneLabel, *anuntTypeLabel; 
@property(nonatomic,retain) IBOutlet UIImageView *thumbnailImageView;
//
@property(nonatomic,retain) IBOutlet UIScrollView *imgScrollView;
@property(nonatomic,retain) IBOutlet UIImageView *imgView;
@property(nonatomic, retain) NSMutableArray *buttonsArray;
@property(nonatomic, retain) TImageList *imgList;


-(void)loadAdWithId:(int)theAdId;
-(void)changeCurrentViewedImageToImageWithIndex:(id) sender;

@end
