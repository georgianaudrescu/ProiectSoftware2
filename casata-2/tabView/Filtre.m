//
//  Filtre.m
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Filtre.h"
#import "OptiuniHartaViewController.h"

@implementation Filtre
@synthesize sliderPretMax,sliderPretMin, pickerView, segmentedControl,pMaxLabel,pMinLabel,selectedPropertyType,aplicaFiltreButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)sliderMinValueChanged:(UISlider *)sender

{
    int discreteValue = round([sender value]);
    discreteValue = discreteValue*1000;
    pMinLabel.text = [NSString stringWithFormat:@"%d", discreteValue];
}
-(IBAction)sliderMaxValueChanged:(UISlider *)sender

{   int discreteValue = round([sender value]);
    discreteValue=discreteValue*1000;
    pMaxLabel.text = [NSString stringWithFormat:@"%d", discreteValue];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

///warningul nu este important, se returneaza optiuni harta viewcontroller
-(IBAction)aplicaFiltre:(id)sender
{
    //if(segmentedControl.selectedSegmentIndex==0)
    NSLog(@"selected seg index: %d", segmentedControl.selectedSegmentIndex);
    NSLog(@"selected propertytype index: %d", selectedPropertyType); 
    
    NSLog(@"pret min %@",pMinLabel.text);
    NSLog(@"pret max %@",pMaxLabel.text);
    
    
    
     
    //UIViewController *mainViewController = [self.view.superview nextResponder];
    OptiuniHartaViewController *controller = self.view.superview.nextResponder;
    
    if(controller && [controller isKindOfClass: [OptiuniHartaViewController class]])
        [controller.navigationController popToRootViewControllerAnimated:YES];
    
  // [mainViewController.navigationController popToRootViewControllerAnimated:YES];
}




-(void)dealloc
{ [pickerView release];
    [sliderPretMax release];
    [sliderPretMin release];
    [segmentedControl release];
    [pMaxLabel release];
    [pMinLabel release];


    [super dealloc];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;

}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [propertyTypes count];
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    return [propertyTypes objectAtIndex:row];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedPropertyType = row+1;
    NSLog(@"selected picker line: %@, index: %i", [propertyTypes objectAtIndex:row], row);
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    selectedPropertyType=0;
    
    propertyTypes = [[NSMutableArray alloc] init];
    [propertyTypes addObject:@"Garsoniera"];
    [propertyTypes addObject:@"Aprtament 2 camere"];
    [propertyTypes addObject:@"Apartament 3 camere"];
    [propertyTypes addObject:@"Apartament 4 camere"];
    [propertyTypes addObject:@"Casa"];
    
    
    //[self.view setClipsToBounds:YES];/////
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
