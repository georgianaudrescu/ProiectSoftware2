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
}
@property(nonatomic,retain) TAd *theAd;
@property(nonatomic,retain) IBOutlet UILabel *nameLabel,*propertyTypeLabel, *adTextLabel, *adressLineLabel, *pretLabel, *monedaLabel, *contactNameLabel, *contactPhoneLabel, *anuntTypeLabel; 
@property(nonatomic,retain) IBOutlet UIImageView *thumbnailImageView;

-(void)loadAdWithId:(int)theAdId;

@end
