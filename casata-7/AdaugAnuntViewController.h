//
//  AdaugAnuntViewController.h
//  casata
//
//  Created by me on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdaugaImaginiViewController.h"
#import "TAd.h"
#import "AppDelegate.h"

#define tipImobil 0
#define nrCamere 1

@interface AdaugAnuntViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
{
    IBOutlet UITextField * titluTextField;
    IBOutlet UITextField * pretTextField;
    //IBOutlet UITextField * camereTextField;
    IBOutlet UITextField * suprafataTextField;
    IBOutlet UITextView * detaliiTextView;
    UISegmentedControl *tipAnuntSegmentedControl;
    UISegmentedControl *monedaSegmentedControl;
    UITableView  *tableImobil;
    NSString * selectedPropType;
    NSIndexPath *selectedIndex;
    NSMutableArray *tableItems;
    NSMutableArray *tableValues;
    UIPickerView * pickerView;
    NSMutableArray *propertyTypes;
    NSMutableArray *camere;
    TAd *theNewAd;
    int flagDateNecompletate;
    IBOutlet UITextField * orasTextField;
    IBOutlet UITextField * judetTextField;
    IBOutlet UITextField * adresaTextField;
    AppDelegate *apdelegate;
    id delegate;
    SEL refreshMyAdsTable;
    int flagAnuntVechi;
}

//@property (nonatomic,retain) IBOutlet UIScrollView * scrollView;
@property (nonatomic, retain) IBOutlet UITableView *tableImobil;
@property (nonatomic, strong) IBOutlet UITextField * pretTextField;
@property (nonatomic, strong) IBOutlet UITextField * titluTextField;
@property (nonatomic, retain) IBOutlet  UISegmentedControl *tipAnuntSegmentedControl;
@property (nonatomic, retain) IBOutlet  UISegmentedControl *monedaSegmentedControl;//@property (nonatomic, strong) IBOutlet UITextField * camereTextField;
@property (nonatomic, strong) IBOutlet UITextField * suprafataTextField;
@property (nonatomic, strong) IBOutlet UITextView * detaliiTextView;
@property (nonatomic, retain) UIPickerView * pickerView;
@property (nonatomic, strong) IBOutlet UITextField * orasTextField, *judetTextField, * adresaTextField;
@property(assign) id delegate;
@property(assign) SEL refreshMyAdsTable;
@property (nonatomic, retain) TAd * theNewAd;


-(IBAction)textFieldReturn:(id)sender;
-(IBAction)backgroundTouched:(id)sender;
- (void) animateTextField: (UITextField*) textField up: (BOOL) up;
- (void) animateTextView: (UITextView*) textView up: (BOOL) up;

-(void) showTipImobilPicker;
-(void)salveazaAnunt;


-(IBAction)adaugaImagini:(id)sender;
-(IBAction)adaugaLocatie:(id)sender;

-(void) reverseGeocoding;
-(BOOL) stringIsValid:(NSString *)string;
-(BOOL)isNumeric:(NSString*)s;//

//- (BOOL) validateTextField:(UITextField *)textFiled;

@end
