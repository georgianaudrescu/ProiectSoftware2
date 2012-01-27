//
//  AdaugAnuntViewController.m
//  casata
//
//  Created by me on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AdaugAnuntViewController.h"
#import "AppDelegate.h"
#import "LocalizareViewController.h"
#import "AdaugaImaginiViewController.h"
#import "LocalizareViewController.h"

#define kOFFSET_FOR_KEYBOARD 160.0

@implementation AdaugAnuntViewController
@synthesize pretTextField,tableImobil,titluTextField,detaliiTextView,suprafataTextField;
@synthesize tipAnuntSegmentedControl, monedaSegmentedControl;
@synthesize pickerView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // self.title = NSLocalizedString(@"Adauga anunt", @"Adauga anunt");
       // self.tabBarItem.image = [UIImage imageNamed:@"adauga_anunt"];
       [self setTitle:@"Adauga anunt"];
        //butonul care va aparea ca back button pt view-ul child care va fi pus in stiva peste view-ul curent
        UIBarButtonItem *anuleazaButton = [[[UIBarButtonItem alloc] initWithTitle:@"Inapoi" style:UIBarButtonItemStylePlain target:nil action:nil]autorelease]; 
        
        anuleazaButton.tintColor = [UIColor blackColor];
        
        self.navigationItem.backBarButtonItem= anuleazaButton;  
        
        self.navigationItem.rightBarButtonItem =  [[[UIBarButtonItem alloc] initWithTitle:@"Salveaza" style:UIBarButtonItemStylePlain target:self action:@selector(salveazaAnunt)]autorelease]; 
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    
        newAd = [TAd alloc];
    }
    return self;
}

-(void)salveazaAnunt
{/* NSNumber *adid = [row objectForKey:@"id"];
  NSNumber * latitude = [ row objectForKey:@"long"];
  NSNumber * longitude = [row objectForKey:@"lat"];
  CLLocationCoordinate2D coordinate;
  coordinate.latitude = latitude.doubleValue;
  coordinate.longitude = longitude.doubleValue; 
  NSString * name = [row objectForKey:@"name"];///
  NSString * description = [row objectForKey:@"ad_text"];///
  NSString * type = [row objectForKey:@"ad_type"];///
  NSString * propertyType = [row objectForKey:@"property_type"];
  NSString * contactName = [row objectForKey:@"contact_name"];
  NSString * contactPhone = [row objectForKey:@"contact_phone"];
  NSString * contactEmail = [row objectForKey:@"contact_mail"];
  NSString * address = [row objectForKey:@"adress_line"];
  NSString * judet = [row objectForKey:@"judet"];
  NSString * oras = [row objectForKey:@"oras"];
  NSNumber * price = [row objectForKey:@"pret"];///
  NSString * moneda = [row objectForKey:@"moneda"];///
  */
   
/*    
    
  //de pus un flag, daca oricare din campurile obligatorii sunt necompletate (sau nu are aleasa o locatie) sa apara un alerview cand se apasa "salveza" cu mesajul "datele anuntului sunt incomplete"  
    NSString *name = [NSString stringWithString:self.titluTextField.text];
    NSString *ad_text = [NSString stringWithString:self.detaliiTextView.text];
    NSString *pret = [NSString stringWithString:self.pretTextField.text];
    NSString *size = [NSString stringWithString:self.suprafataTextField.text];
    
   
    NSString *latitude = [NSString stringWithFormat:@"%f", newAd.adlocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", newAd.adlocation.coordinate.longitude];
    
    NSString *ad_type;
    if(self.tipAnuntSegmentedControl.selectedSegmentIndex==0)
    {ad_type = [NSString stringWithString:@"sale"];} 
    else
    {ad_type = [NSString stringWithString:@"rent"];}
    
    NSString *moneda;
    if(self.monedaSegmentedControl.selectedSegmentIndex==0)
    {moneda = [NSString stringWithString:@"lei"];} 
    else
    {moneda = [NSString stringWithString:@"euro"];}
    
    
    NSDictionary *tempDictionary = [[[NSDictionary alloc] initWithObjectsAndKeys:name, @"name", ad_text, @"ad_text", ad_type, @"ad_type", pret, @"pret", size, "@size", moneda, @"moneda",latitude, @"lat", longitude, @"long", nil]autorelease];
    
    NSLog(@"here");
    [newAd TAd:tempDictionary];
    //[tempDictionary release];
 
 */
}

-(void)dealloc
{
    [tipAnuntSegmentedControl release];
    [monedaSegmentedControl release];
    [titluTextField release];
    [pretTextField release];
    [suprafataTextField release];
    [detaliiTextView release];
    //[camereTextField release];
    //[scrollView release];
    [tableImobil release];
    [propertyTypes release];
     
    [pickerView release];
    [tableValues release];
    [newAd release];
        
    [super dealloc];
    
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
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

-(void) textFieldReturn:(id)sender{
    [sender resignFirstResponder];
}

-(void) backgroundTouched:(id)sender{
    [pretTextField resignFirstResponder];
  //[suprafataTextField resignFirstResponder];
    [pretTextField resignFirstResponder];
    [titluTextField resignFirstResponder];
    [detaliiTextView resignFirstResponder];
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.tableImobil setUserInteractionEnabled:NO];
    [self animateTextField: textField up: YES];
}


- (IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    [self.tableImobil setUserInteractionEnabled:YES];
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 120; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text=@"";
    [self.tableImobil setUserInteractionEnabled:NO];
    [self animateTextView: textView up: YES];
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    [self.tableImobil setUserInteractionEnabled:YES];
    [self animateTextView: textView up: NO];
}

- (void) animateTextView: (UITextView*) textView up: (BOOL) up
{
    const int movementDistance = 180; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range  replacementText:(NSString *)text
{
	if (range.length==0) {
		if ([text isEqualToString:@"\n"]) {
			[textView resignFirstResponder];
			return NO;
		}
	}
	
    return YES;
}


- (IBAction)adaugaImagini:(id)sender{

    if(newAd.imageList==nil){ [newAd initImageList];}/////
    
    AdaugaImaginiViewController *adaugaImaginiViewController = [[[AdaugaImaginiViewController alloc] initWithNibName:@"AdaugaImaginiViewController" bundle:nil]autorelease];
    
    adaugaImaginiViewController.tempAd = newAd;
    
    [self.navigationController pushViewController:adaugaImaginiViewController animated:YES];
    
}

- (IBAction)adaugaLocatie:(id)sender{
    
    LocalizareViewController *adaugaLocatieViewController = [[[LocalizareViewController alloc] initWithNibName:@"LocalizareViewController" bundle:nil]autorelease];
    
    adaugaLocatieViewController.tempAd=newAd;
    
    [self.navigationController pushViewController:adaugaLocatieViewController animated:YES];
    
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [tableItems count];
    //return 3;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];;
    }

    
    cell.textLabel.text = [ tableItems objectAtIndex:[indexPath row]];
    
    cell.detailTextLabel.text = [ tableValues objectAtIndex:[indexPath row]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    /*
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor blackColor];
    
    cell.selectedBackgroundView = backgroundView;
    [backgroundView release];
    */
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {   

    UITableViewCell *cell = [tableImobil cellForRowAtIndexPath:indexPath];
   
    if(([cell.textLabel.text isEqual:@"Tip Imobil"])||([cell.textLabel.text isEqual:@"Numar Camere"])){
        [self showTipImobilPicker];
    }
 
    
    //////////////////////////
    /*
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor blackColor];
    
    cell.selectedBackgroundView = backgroundView;
    [backgroundView release];
     */


}
-(void) showTipImobilPicker{
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Tip Imobil si Numar Camere" 
                                                      delegate:self
                                             cancelButtonTitle:nil
                                        destructiveButtonTitle:@"Done"
                                             otherButtonTitles:nil];
    [menu showInView:self.view];
     menu.frame = CGRectMake(0, 100, 320, 420);
    
//    pickerView = [[UIPickerView alloc] init];
//    pickerView.showsSelectionIndicator = YES;
//    pickerView.delegate=self ;
//    
    pickerView.frame = CGRectMake(0, 100, 320, 320);
    [menu addSubview:pickerView];
    
    //[pickerView release];
    [menu release];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
  if(component == tipImobil)
      return 230;
    return 70;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if(component == tipImobil)
    {return [propertyTypes count];}
    
    if(component == nrCamere)
    {return  [camere count];}
            
    return 0;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == tipImobil)
    {   return [propertyTypes objectAtIndex:row];}
    
    if (component == nrCamere)
    { return [camere objectAtIndex:row];}
    
    return 0;
}

-(void) pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString * imobil = [propertyTypes objectAtIndex:[thePickerView selectedRowInComponent:0]];
    NSString * rooms = [camere objectAtIndex:[thePickerView selectedRowInComponent:1]];
    NSLog(@"Tip imobil: %@, %@ camere", imobil,rooms);
    [tableValues replaceObjectAtIndex:0 withObject:imobil];
    [tableValues replaceObjectAtIndex:1 withObject:rooms];
    [tableImobil reloadData];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //selectedPropType = nil;
    tableItems = [[NSMutableArray alloc] initWithObjects:@"Tip Imobil",@"Numar Camere", nil];

    tableValues = [[NSMutableArray alloc] initWithObjects:@"Garsoniera",@"1", nil];
    
    pickerView = [[UIPickerView alloc] init];
    pickerView.showsSelectionIndicator = YES;
    pickerView.delegate=self ;
    pickerView.dataSource = self;
    
    propertyTypes = [[NSMutableArray alloc] init];
    [propertyTypes addObject:@"Garsoniera"];
    [propertyTypes addObject:@"Apartament"];
    [propertyTypes addObject:@"Casa"];
    [propertyTypes addObject:@"Spatiu Comercial"];
    
    camere = [[NSMutableArray alloc] init];
    [camere addObject:@"0"];
    [camere addObject:@"1"];
    [camere addObject:@"2"];
    [camere addObject:@"3"];
    [camere addObject:@"4"];
    [camere addObject:@"5+"];
    
    self.detaliiTextView.delegate = self;
    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
