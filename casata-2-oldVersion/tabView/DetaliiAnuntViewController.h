//
//  DetaliiAnuntViewController.h
//  casata
//
//  Created by me on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface DetaliiAnuntViewController : UIViewController
{
    int ad_id;
    AppDelegate *apdelegate;
    UILabel *nameLabel;
    UILabel *propertyTypeLabel;
    UILabel *adTextlabel;
    UILabel *adressLineLabel;
    UILabel *pretLabel;
    UILabel *monedaLabel;
    UILabel *contactNameLabel;
    UILabel *contactPhoneLabel;
}
@property(nonatomic,assign) int ad_id;
@property(nonatomic,retain) IBOutlet UILabel *nameLabel,*propertyTypeLabel, *adTextLabel, *adressLineLabel, *pretLabel, *monedaLabel, *contactNameLabel, *contactPhoneLabel; 


@end
