//
//  AdaugAnuntViewController.h
//  casata
//
//  Created by me on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdaugaImaginiViewController.h"

@interface AdaugAnuntViewController : UIViewController
{
    IBOutlet UITextField * pretTextField;
    IBOutlet UITextField * suprafataTextField;
    
}


@property (nonatomic, strong) IBOutlet UITextField * pretTextField;
@property (nonatomic, strong) IBOutlet UITextField * suprafataTextField;


-(IBAction)textFieldReturn:(id)sender;
-(IBAction)backgroundTouched:(id)sender;

-(IBAction)adaugaImagini:(id)sender;

@end
