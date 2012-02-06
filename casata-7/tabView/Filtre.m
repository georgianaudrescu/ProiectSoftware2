//
//  Filtre.m
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Filtre.h"
#import "AppDelegate.h"
//#import "TableWithCheckBox.h"
//#import "OptiuniHartaViewController.h"




@implementation Filtre
@synthesize sliderPretMax,sliderPretMin, segmentedControl,pMaxLabel,pMinLabel,selectedRowsArray;

@synthesize tableImobil;
@synthesize supMaxLabel,supMinLabel, sliderSuprafataMax,sliderSuprafataMin;
@synthesize delegate, seAplicaFiltre, seStergFiltre;
@synthesize headerText, headerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Filtre", @"Filtre");
        //self.tabBarItem.image = [UIImage imageNamed:@"filter"];
        // Custom initialization
        [self setTitle:@"Filtre"];
        [self initsliders];
        apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];        
        
        tableImobil = [[UITableView alloc] init];
        [tableImobil setAutoresizesSubviews:YES];
        [tableImobil setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        selectedRowsArray = [[NSMutableArray alloc] initWithCapacity:0];
       
      
    }
    
    return self;
}
-(void)setTitle:(NSString *)title
{
    [super setTitle:@"Filtre"];
    UILabel *titleView = (UILabel *) self.navigationItem.titleView;
    if(!titleView)
    {titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont boldSystemFontOfSize:20];
        //titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        titleView.textColor = [UIColor blackColor];
        self.navigationItem.titleView = titleView;
        [titleView release];
    }
    titleView.text = title;
    [titleView sizeToFit];
  
    
}
- (void)backToStatistics{
    
    //for animation
    self.view.frame = CGRectMake(0,0, 320, 460);
    
    [UIView animateWithDuration:0.5 
                     animations:^{self.view.frame = CGRectMake(320,0, 320, 460);}
                     completion:^(BOOL completed){[self.view removeFromSuperview];}];
    
    
    
}


-(void)clearFilters{
    ///TODO
}

/*
 -(NSMutableDictionary *)applyFilters{
 NSUInteger type = [self.segmentedControl selectedSegmentIndex];
 NSString *types = [self.segmentedControl titleForSegmentAtIndex:type];
 //NSNumber *typenr = [NSNumber numberWithInt:type];
 NSMutableArray *propertyy = self.selectedRowsArray;
 NSString *pmin = self.pMinLabel.text;
 NSString * pmax = self.pMaxLabel.text;
 NSString * smin = self.supMinLabel.text;
 NSString * smax = self.supMaxLabel.text;
 NSLog(@"in applyfil %@ , %@, %@ , %@ , %@", types, pmin, pmax, smin, smax);
 NSMutableDictionary *filtre = [NSMutableDictionary alloc];
 filtre = [NSMutableDictionary dictionaryWithObjectsAndKeys:
 types,@"types",
 propertyy,@"propertyy", 
 pmin,@"pmin",
 pmax,@"pmax",
 smin,@"smin",
 smax,@"smax",
 nil];
 return filtre;
 }
 */

-(void)initsliders
{
    NSLog(@"in slider");
    
    
    
    if([self.pMinLabel.text intValue] != 0) //daca s-a modificat pretul minim
    {
        //setez valoarea minima a pretului maxim
        sliderPretMax.minimumValue = [self.pMinLabel.text intValue]/100;
    }
    if([self.supMinLabel.text intValue] != 0) //daca s-a modificat valoarea suprafetei minime
    {
        //setez valoarea minima a suprafetei maxim
        sliderSuprafataMax.minimumValue = [self.supMinLabel.text intValue]/5;
    }
    
    /*
    //scriu in label int
    int supmaxx =sliderSuprafataMax.maximumValue *5;
    supMaxLabel.text = [NSString stringWithFormat:@"%d",supmaxx]; 
    int pretmaxx = sliderPretMax.maximumValue *100;
    pMaxLabel.text = [NSString stringWithFormat:@"%d", pretmaxx];
    
    */
}

-(IBAction)segmentedAnuntTypeChanged:(id)sender
{
    if(self.segmentedControl.selectedSegmentIndex == 0) //daca este de vanzare
    {
        //setez valoarea maxima a pretului minim
         sliderPretMin.minimumValue=0;
        sliderPretMin.maximumValue = 200;
       [sliderPretMin setValue:0];
        //setez valoarea maxima a pretului maxim
        sliderPretMax.minimumValue=200;
        sliderPretMax.maximumValue = 5000;
        [sliderPretMax setValue:200];
        self.pMinLabel.text=@"0";
        self.pMaxLabel.text = @"20000";
        
    } else if (self.segmentedControl.selectedSegmentIndex == 1) //daca este de inchiriere
    {
        //setez alta valoare maxima a pretului minim
        sliderPretMin.minimumValue=0;
        sliderPretMin.maximumValue = 10;
        [sliderPretMin setValue:0];
        //setez alta valoarea maxima a pretului maxim
        sliderPretMax.minimumValue=10;
        sliderPretMax.maximumValue = 300;
        [sliderPretMax setValue:10];
        self.pMinLabel.text =@"0";
         self.pMaxLabel.text = @"100";
    }
}

-(IBAction)aplicaFiltre:(id)sender
{   
    NSUInteger type = [self.segmentedControl selectedSegmentIndex];
    NSString *types;
    
    NSString *anuntType;
    if(type==0)
    {types = @"sell";
        anuntType=[NSString stringWithString:@"vanzare"];
    }
    else {types=@"rent";
        anuntType = [NSString stringWithString:@"inchiriere"];
    }
    
    NSMutableArray *property =[NSMutableArray arrayWithArray:self.selectedRowsArray];
    
    NSNumber *pmin = [NSNumber numberWithInt:([self.pMinLabel.text intValue])];
    NSNumber * pmax = [NSNumber numberWithInt:([self.pMaxLabel.text intValue])];
    NSNumber * smin = [NSNumber numberWithInt:([self.supMinLabel.text intValue])];
    NSNumber * smax = [NSNumber numberWithInt:([self.supMaxLabel.text intValue])];  
    
    NSMutableString * propString= [NSMutableString stringWithString:@""];
    for(int x=0; x<property.count; x++)
    {
        if(x>0){ [propString appendString:@","]; }
        
        if([[property objectAtIndex:x] isEqual:@"apartament 4 camere"]){
            [propString appendString:@"4camere"];
        }
        else 
            if([[property objectAtIndex:x] isEqual:@"apartament 3 camere"]){
                [propString appendString:@"3camere"];
            }
            else 
                if([[property objectAtIndex:x] isEqual:@"apartament 2 camere"]){
                    [propString appendString:@"2camere"];
                }
                else{
                    [propString appendString:[property objectAtIndex:x]];
                }
        
        
    }
    
    NSString *header =[NSString stringWithFormat:@"%@-%@ euro, %@-%@ mp, %@, %@ ",pmin,pmax,smin,smax,anuntType,propString];
    //headerText.text= header;
    
    [self.headerText setText:header];
    NSLog(@"%@",header);
    
    
    apdelegate.appSession.filtre = [NSMutableDictionary dictionaryWithObjectsAndKeys:types, @"ad_type", property, @"property_type", pmin, @"p_min", pmax, @"p_max", smin, @"size_min", smax, @"size_max", nil];
    
    NSLog(@"apasat");
    NSLog(@"FILTRE nsdict: %@",apdelegate.appSession.filtre);
    
    [delegate performSelector:seAplicaFiltre]; //pt a ajunge in mapViewcontroller
}

-(IBAction)clearFiltre:(id)sender
{
    [self.headerText setText:@"Nici un filtru aplicat"];
    apdelegate.appSession.filtre=nil;
    NSLog(@"clear");
    
    [delegate performSelector:seStergFiltre];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [propertyTypes count];
    //return 5;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if ([selectedRowsArray containsObject:[propertyTypes objectAtIndex:indexPath.row]]) {
        cell.imageView.image = [UIImage imageNamed:@"checkbox_ticked.png"];
        
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"checkbox_not_ticked.png"];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChecking:)];
    [cell.imageView addGestureRecognizer:tap];
    [tap release];
    
    cell.textLabel.text = [ propertyTypes objectAtIndex:[indexPath row]];
    //  return cell;
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor blackColor];
    
    cell.selectedBackgroundView = backgroundView;
    [backgroundView release];
    
    
    //cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    //cell.textLabel.text = [NSString	 stringWithFormat:@"Cell Row #%d", [indexPath row]];
    //cell.textLabel.text = [ propertyTypes objectAtIndex:[indexPath row]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// open a alert with an OK and cancel button
	/*
     NSString *alertString = [NSString stringWithFormat:@"Clicked on row #%d", [indexPath row]];
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:@"" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
     [alert show];
     [alert release];
     */
    UITableViewCell *cell = [tableImobil cellForRowAtIndexPath:indexPath];
    if([selectedRowsArray containsObject:[cell.textLabel.text lowercaseString]])
    {
        cell.imageView.image = [UIImage imageNamed:@"checkbox_not_ticked.png"];
        [selectedRowsArray removeObject:[cell.textLabel.text lowercaseString]];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"checkbox_ticked.png"];
        [selectedRowsArray addObject:[cell.textLabel.text lowercaseString]];
    }
    // NSLog(@"%@",selectedRowsArray);
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor blackColor];
    
    cell.selectedBackgroundView = backgroundView;
    [backgroundView release];
}


-(IBAction)sliderMinValueChanged:(UISlider *)sender

{
   if(self.segmentedControl.selectedSegmentIndex==1)
   {
       int discreteValue = round([sender value]);
       NSLog(@"minim price %d", discreteValue);
       discreteValue = discreteValue*10;
       pMinLabel.text = [NSString stringWithFormat:@"%d", discreteValue];
       sliderPretMax.minimumValue = [self.pMinLabel.text intValue]/10;
   }
   else{
    int discreteValue = round([sender value]);
    NSLog(@"minim price %d", discreteValue);
    discreteValue = discreteValue*100;
    pMinLabel.text = [NSString stringWithFormat:@"%d", discreteValue];
    sliderPretMax.minimumValue = [self.pMinLabel.text intValue]/100;
   }
}
-(IBAction)sliderMaxValueChanged:(UISlider *)sender

{   if(self.segmentedControl.selectedSegmentIndex==1)

{   
    int discreteValue = round([sender value]);
    NSLog(@"maxim price %d", discreteValue);
    discreteValue=discreteValue*10;
    pMaxLabel.text = [NSString stringWithFormat:@"%d", discreteValue];
}
else{
    
    int discreteValue = round([sender value]);
    NSLog(@"maxim price %d", discreteValue);
    discreteValue=discreteValue*100;
    pMaxLabel.text = [NSString stringWithFormat:@"%d", discreteValue];
}
}

-(IBAction)sliderSupMinValueChanged:(UISlider *)sender

{
    int discreteValue = round([sender value]);
    NSLog(@"supmin price %d", discreteValue);
    discreteValue = discreteValue*10;
    supMinLabel.text = [NSString stringWithFormat:@"%d", discreteValue];
     sliderSuprafataMax.minimumValue = [self.supMinLabel.text intValue]/10;
}
-(IBAction)sliderSupMaxValueChanged:(UISlider *)sender

{   int discreteValue = round([sender value]);
    NSLog(@"supmax price %d", discreteValue);
    discreteValue=discreteValue*10;
    supMaxLabel.text = [NSString stringWithFormat:@"%d", discreteValue];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

///warningul nu este important, se returneaza optiuni harta viewcontroller

/*
 -(IBAction)aplicaFiltre:(id)sender
 {
 //if(segmentedControl.selectedSegmentIndex==0)
 NSLog(@"selected seg index: %d", segmentedControl.selectedSegmentIndex);
 NSLog(@"selected propertytype index: %d", selectedPropertyType); 
 
 NSLog(@"pret min %@",pMinLabel.text);
 NSLog(@"pret max %@",pMaxLabel.text);
 
 
 
 
 //UIViewController *mainViewController = [self.view.superview nextResponder];
 //OptiuniHartaViewController *controller = self.view.superview.nextResponder;
 
 //if(controller && [controller isKindOfClass: [OptiuniHartaViewController class]])
 // [controller.navigationController popToRootViewControllerAnimated:YES];
 
 // [mainViewController.navigationController popToRootViewControllerAnimated:YES];
 }
 */



-(void)dealloc
{ //[pickerView release];
    [tableImobil release];
    [sliderPretMax release];
    [sliderPretMin release];
    [segmentedControl release];
    [pMaxLabel release];
    [pMinLabel release];
    [headerView release];
    
    [super dealloc];
}
/*
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
 */

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, 580)];
    // Do any additional setup after loading the view from its nib.
    
    //selectedPropertyType=0;
    
    propertyTypes = [[NSMutableArray alloc] init];
    [propertyTypes addObject:@"Garsoniera"];
    [propertyTypes addObject:@"Apartament 2 camere"];
    [propertyTypes addObject:@"Apartament 3 camere"];
    [propertyTypes addObject:@"Apartament 4 camere"];
    [propertyTypes addObject:@"Casa"];
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backToStatistics)];
    swipeRight.numberOfTouchesRequired=1;
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.headerView addGestureRecognizer:swipeRight]; 
    [swipeRight release];
    
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