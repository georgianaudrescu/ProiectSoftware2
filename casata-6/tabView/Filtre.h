//
//  Filtre.h
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TableWithCheckBox.h"
#import "AppDelegate.h"

@interface Filtre : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    IBOutlet UIScrollView * scrollView;
    
    //UIPickerView *pickerView;
    UISegmentedControl *segmentedControl;
    UISlider *sliderPretMin;
    UISlider *sliderPretMax;
    UISlider *sliderSuprafataMin;
    UISlider *sliderSuprefataMax;
    NSMutableArray *propertyTypes;
    UILabel *pMinLabel, *pMaxLabel;
    UILabel *supMinLabel, *supMaxLabel;
    //int selectedPropertyType;
    //UIButton *aplicaFiltreButton;
    UITableView  *tableImobil;
    NSMutableArray * selectedRowsArray;
    UILabel * headerText;
    
    
    
    //pt map ca delegate
    id delegate;
    SEL seAplicaFiltre;
    SEL seStergFiltre;
    
    AppDelegate *apdelegate;
    
}

//@property(nonatomic,assign) int selectedPropertyType;
@property (nonatomic, retain) NSMutableArray * selectedRowsArray;	
//@property(nonatomic,retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic, retain) IBOutlet UITableView *tableImobil;
@property(nonatomic,retain) IBOutlet UISegmentedControl *segmentedControl;
@property(nonatomic,retain) IBOutlet UISlider *sliderPretMin;
@property(nonatomic,retain) IBOutlet UISlider *sliderPretMax;
@property(nonatomic,retain) IBOutlet UILabel *pMinLabel, *pMaxLabel;
@property(nonatomic,retain) IBOutlet UISlider *sliderSuprafataMin;
@property(nonatomic,retain) IBOutlet UISlider *sliderSuprafataMax;
@property(nonatomic,retain) IBOutlet UILabel *supMinLabel, *supMaxLabel;
//@property(nonatomic,retain)IBOutlet UIButton *aplicaFiltreButton;
@property(assign) id delegate;
@property(assign) SEL seAplicaFiltre;
@property(assign) SEL seStergFiltre;
@property(nonatomic, retain) IBOutlet UILabel * headerText;


-(IBAction)sliderMinValueChanged:(UISlider *)sender;
-(IBAction)sliderMaxValueChanged:(UISlider *)sender;
-(IBAction)sliderSupMinValueChanged:(UISlider *)sender;
-(IBAction)sliderSupMaxValueChanged:(UISlider *)sender;

-(IBAction)backToStatistics:(id)sender ;

//-(void)clearFilters;
//-(NSMutableDictionary *)applyFilters;

-(IBAction)aplicaFiltre:(id)sender;
-(IBAction)clearFiltre:(id)sender;

@end
