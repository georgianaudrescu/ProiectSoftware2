//
//  AdaugAnuntViewController.h
//  casata
//
//  Created by me on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdaugaImaginiViewController.h"

@interface AdaugAnuntViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
{
    UIScrollView * scrollView;
    IBOutlet UITextField * titluTextField;
    IBOutlet UITextField * pretTextField;
    IBOutlet UITextField * camereTextField;
    IBOutlet UITextField * suprafataTextField;
    IBOutlet UITextView * detaliiTextView;
    UITableView  *tableImobil;
    NSMutableArray *propertyTypes;
    NSString * selectedPropType;
    //NSInteger selectedRow;
    NSIndexPath *selectedIndex;
    //UITextField *activeField;
}

@property (nonatomic,retain) IBOutlet UIScrollView * scrollView;
@property (nonatomic, retain) IBOutlet UITableView *tableImobil;
@property (nonatomic, strong) IBOutlet UITextField * pretTextField;
@property (nonatomic, strong) IBOutlet UITextField * titluTextField;
@property (nonatomic, strong) IBOutlet UITextField * camereTextField;
@property (nonatomic, strong) IBOutlet UITextField * suprafataTextField;
@property (nonatomic, strong) IBOutlet UITextView * detaliiTextView;

//-(void)tableView: (UITableView *) tableView unCheckRow:(NSIndexPath*) indexPath;

-(IBAction)textFieldReturn:(id)sender;
-(IBAction)backgroundTouched:(id)sender;
- (void) animateTextField: (UITextField*) textField up: (BOOL) up;
- (void) animateTextView: (UITextView*) textView up: (BOOL) up;



-(IBAction)adaugaImagini:(id)sender;
-(IBAction)adaugaLocatie:(id)sender;

@end
