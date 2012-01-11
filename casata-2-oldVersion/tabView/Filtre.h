//
//  Filtre.h
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Filtre : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIPickerView *pickerView;
    UISegmentedControl *segmentedControl;
    UISlider *sliderPretMin;
    UISlider *sliderPretMax;
    NSMutableArray *propertyTypes;
    UILabel *pMinLabel, *pMaxLabel;
    int selectedPropertyType;
    UIButton *aplicaFiltreButton;


}
@property(nonatomic,assign) int selectedPropertyType;
@property(nonatomic,retain) IBOutlet UIPickerView *pickerView;
@property(nonatomic,retain) IBOutlet UISegmentedControl *segmentedControl;
@property(nonatomic,retain) IBOutlet UISlider *sliderPretMin;
@property(nonatomic,retain) IBOutlet UISlider *sliderPretMax;
@property(nonatomic,retain) IBOutlet UILabel *pMinLabel, *pMaxLabel;
@property(nonatomic,retain)IBOutlet UIButton *aplicaFiltreButton;


-(IBAction)sliderMinValueChanged:(UISlider *)sender;
-(IBAction)sliderMaxValueChanged:(UISlider *)sender;

-(IBAction)aplicaFiltre:(id)sender;

@end
