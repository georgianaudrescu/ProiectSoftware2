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
}
@property(nonatomic,assign) int ad_id;
@end
