//
//  MyAdsViewController.h
//  casata
//
//  Created by Oana B on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MyAdsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate, UIScrollViewDelegate>
{
    
    UITableView *tableAds;
    UIView *headerView;
    UIView *dateContact;
    UIView *headerDateContact;
    int tapHeader;
    AppDelegate *apdelegate;
    UITextField * userName;
    UITextField * phone;
    UITextField * email;
    UIScrollView * scrollView;
    
}

@property (nonatomic, retain) IBOutlet UITableView *tableAds;
@property(nonatomic,retain) IBOutlet UIView *headerView;
@property (nonatomic, retain) IBOutlet UIView *dateContact;
@property (nonatomic, retain) IBOutlet UIView *headerDateContact;
@property (nonatomic, retain) IBOutlet UITextField * userName;
@property (nonatomic, retain) IBOutlet UITextField * phone;
@property (nonatomic, retain) IBOutlet UITextField * email;
@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;

-(void)backToStatistics;
-(void) publicaAnunt:(id)sender;
-(void) openDateContact;
-(IBAction) textFieldReturn:(id)sender;
-(void) animateTextField: (UITextField*) textField up: (BOOL) up;
-(IBAction)salveazaDateContact:(id)sender;
-(BOOL) validateTextField:(UITextField *)textFiled;
-(void) refreshMyAdsTable;
@end
