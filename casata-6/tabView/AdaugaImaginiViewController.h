//
//  AdaugaImaginiViewController.h
//  casata
//
//  Created by me on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TImageList.h"

@interface AdaugaImaginiViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>
{
    TImageList *theImageList;
    UIScrollView *generalScrollView;
    UIScrollView *imgScrollView;
    //UIImageView *imgView;
    NSMutableArray *imageViewsArray;
    //
    UIButton *preiaDinGalerie;
    UIButton *preiaCuCamera;
    //UIButton *stergeButton;
    UITextField *titluImagineTextField;
    //UITextField *descriereImagineTextField;
    //UISwitch *valoareDefault;
    UIImagePickerController *picker;
    int currentImageNr;
    int totalImages;
    UIView *viewModal;
    UIToolbar *toolBar;
   }
@property (nonatomic, retain) TImageList *theImageList;
@property (nonatomic, retain) IBOutlet UIScrollView *imgScrollView;
@property (nonatomic, retain) IBOutlet UIScrollView *generalScrollView;
//@property (nonatomic, retain) IBOutlet UIImageView *imgView;
@property(nonatomic, retain) NSMutableArray *imageViewsArray;
@property(nonatomic, retain) IBOutlet UIButton *preiaDinGalerie, *preiaCuCamera;
@property(nonatomic, retain) IBOutlet UITextField *titluImagineTextField;
//@property(nonatomic, retain) IBOutlet UISwitch *valoareDefault;
@property(nonatomic, retain) UIImagePickerController *picker;
@property(nonatomic, assign) int currentImageNr;
@property(nonatomic, assign) int totalImages;
@property(nonatomic, retain) IBOutlet UIView *viewModal;
@property(nonatomic,retain) IBOutlet UIToolbar *toolBar;

-(IBAction)preiaImagine:(id)sender;
-(IBAction)stergeImagineCurenta:(id)sender;
//-(IBAction)switchChangedForCurrentImage:(id)sender;
//-(void)changeCurrentViewedImageToImageWithIndex:(id) sender;
-(IBAction) textFieldReturn:(id)sender;
-(IBAction) backgroundTouched:(id)sender;
-(IBAction)enterEditingModeForTextField:(id)sender;
-(void)setCurrentImageAsDefault;
-(IBAction)prezintaViewModal:(id)sender;
-(IBAction)getRightOfModalMenu:(id)sender;

@end
