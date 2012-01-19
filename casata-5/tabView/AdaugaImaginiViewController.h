//
//  AdaugaImaginiViewController.h
//  casata
//
//  Created by me on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TImageList.h"

@interface AdaugaImaginiViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    TImageList *theImageList;
    UIScrollView *imgScrollView;
    UIImageView *imgView;
    NSMutableArray *buttonsArray;
    //
    UIButton *preiaDinGalerie;
    UIButton *preiaCuCamera;
    UITextField *titluImagine;
    UITextField *descriereImagine;
    UISwitch *valoareDefault;
    UIImagePickerController *picker;
}
@property (nonatomic, retain) TImageList *theImageList;
@property (nonatomic, retain) IBOutlet UIScrollView *imgScrollView;
@property (nonatomic, retain) IBOutlet UIImageView *imgView;
@property(nonatomic, retain) NSMutableArray *buttonsArray;
@property(nonatomic, retain) IBOutlet UIButton *preiaDinGalerie, *preiaCuCamera;
@property(nonatomic, retain) IBOutlet UITextField *titluImagine, *descriereImagine;
@property(nonatomic, retain) IBOutlet UISwitch *valoareDefault;
@property(nonatomic, retain) UIImagePickerController *picker;

-(IBAction)preiaImagine:(id)sender;
@end
