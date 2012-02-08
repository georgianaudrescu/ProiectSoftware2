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
@interface DetaliiAnuntViewController : UIViewController <UITextViewDelegate>
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
    UILabel *contactEmailLabel;
    UILabel *propertySize;
    UIImageView *thumbnailImageView;
    UIButton *favButton;
    //
    UIScrollView *imgScrollView;
    UIImageView *imgView;
    NSMutableArray *imageViewsArray;
    TImageList *imgList;
    id delegate;
    SEL hidePinIfRemovedFromFav;
    UIScrollView *bigScroll;
    UITextView *adTextView;
    UIButton *callButton;
    UIView * headerView;
    UIView * imaginiView;
    UIView * detaliiView;
    UIView * contactView;
    NSThread *imagesThread;
    int flagThread;
    BOOL avemConexiune;
}
@property(nonatomic,retain) TAd *theAd;
@property(nonatomic,retain) IBOutlet UILabel *nameLabel,*propertyTypeLabel, *adTextLabel, *adressLineLabel, *pretLabel, *monedaLabel, *contactNameLabel, *contactPhoneLabel, *anuntTypeLabel, *contactEmailLabel, *propertySize; 
@property(nonatomic,retain) IBOutlet UIImageView *thumbnailImageView;
@property(nonatomic,retain) IBOutlet UIButton *favButton;
//
@property(nonatomic,retain) IBOutlet UIScrollView *imgScrollView;
@property(nonatomic,retain) IBOutlet UIImageView *imgView;
@property(nonatomic, retain) NSMutableArray *imageViewsArray;
@property(nonatomic, retain) TImageList *imgList;
@property (assign) id delegate;
@property (assign) SEL hidePinIfRemovedFromFav;
@property (nonatomic, retain) IBOutlet UIScrollView * bigScroll;
@property (nonatomic,retain) IBOutlet UITextView * adTextView;
@property(nonatomic,retain)IBOutlet UIButton *callButton;
@property (nonatomic, retain)IBOutlet UIView * headerView;
@property (nonatomic, retain)IBOutlet UIView * imaginiView;
@property (nonatomic, retain)IBOutlet UIView * detaliiView;
@property (nonatomic, retain)IBOutlet UIView * contactView;

-(void)loadAdWithId:(int)theAdId internetActive:(BOOL)internetIsActive;
//-(void)changeCurrentViewedImageToImageWithIndex:(id) sender;

-(IBAction)favButtonPressed:(UIButton*)sender;
-(IBAction)detaliiButtonPressed:(id)sender;
-(IBAction)contactButtonPressed:(id)sender;
-(IBAction)upToImg:(id)sender;

-(UIImage*) imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
-(IBAction)callOwner:(UIButton*)sender;
-(void) getImages;
-(void) afisImages;
@end
