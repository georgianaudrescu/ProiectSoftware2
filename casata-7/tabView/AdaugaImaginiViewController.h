//
//  AdaugaImaginiViewController.h
//  casata
//
//  Created by me on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TImageList.h"
#import "TAd.h"

@interface AdaugaImaginiViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>
{
    //TImageList *theImageList;
    
    TAd *tempAd;
    UIScrollView *generalScrollView;
    UIScrollView *imgScrollView;
    //UIImageView *imgView;
    NSMutableArray *imageViewsArray;
    //
    //UITextField *titluImagineTextField;
    //UITextField *descriereImagineTextField;
    //UISwitch *valoareDefault;
    UIImagePickerController *picker;
    int currentImageNr;
    int totalImages;
    int defaultImageIndex;
    UIToolbar *toolBar;
    UIView *disabledView;
    UIView *defaultView;
   }
//@property (nonatomic, retain) TImageList *theImageList;
@property (nonatomic, retain) IBOutlet UIScrollView *imgScrollView;
@property (nonatomic, retain) IBOutlet UIScrollView *generalScrollView;
//@property (nonatomic, retain) IBOutlet UIImageView *imgView;
@property(nonatomic, retain) NSMutableArray *imageViewsArray;
//@property(nonatomic, retain) IBOutlet UITextField *titluImagineTextField;
//@property(nonatomic, retain) IBOutlet UISwitch *valoareDefault;
@property(nonatomic, retain) UIImagePickerController *picker;
@property(nonatomic, assign) int currentImageNr;
@property(nonatomic, assign) int totalImages;
@property(nonatomic, assign) int defaultImageIndex;
@property(nonatomic,retain) IBOutlet UIToolbar *toolBar;
@property(nonatomic,retain) IBOutlet UIView *disabledView;
@property(nonatomic,retain) IBOutlet UIView *defaultView;
@property(nonatomic,retain) TAd *tempAd;

-(IBAction)preiaImagineCuCamera:(id)sender;
-(IBAction)preiaImagineDinGalerie:(id)sender;
-(IBAction)stergeImagineCurenta:(id)sender;
-(IBAction) textFieldReturn:(id)sender;
-(IBAction) backgroundTouched:(id)sender;
-(IBAction)enterEditingModeForTextField:(id)sender;
-(void)setCurrentImageAsDefault;
-(void)showAlreadyExistentImages;

-(UIImage*) imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;//

@end
