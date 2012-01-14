//
//  Filtre.h
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TableWithCheckBox.h"

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
    int selectedPropertyType;
    //UIButton *aplicaFiltreButton;
   UITableView  *tableImobil;
    NSMutableArray * selectedRowsArray;


}
@property(nonatomic,assign) int selectedPropertyType;
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


-(IBAction)sliderMinValueChanged:(UISlider *)sender;
-(IBAction)sliderMaxValueChanged:(UISlider *)sender;
-(IBAction)sliderSupMinValueChanged:(UISlider *)sender;
-(IBAction)sliderSupMaxValueChanged:(UISlider *)sender;

//-(void)clearFilters;
//-(void)applyFilters;

//-(IBAction)aplicaFiltre:(id)sender;

@end
