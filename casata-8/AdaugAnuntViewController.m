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
@synthesize orasTextField, judetTextField, adresaTextField;
@synthesize delegate, refreshMyAdsTable, theNewAd;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // self.title = NSLocalizedString(@"Adauga anunt", @"Adauga anunt");
       // self.tabBarItem.image = [UIImage imageNamed:@"adauga_anunt"];
       
        //butonul care va aparea ca back button pt view-ul child care va fi pus in stiva peste view-ul curent
        UIBarButtonItem *anuleazaButton = [[[UIBarButtonItem alloc] initWithTitle:@"Inapoi" style:UIBarButtonItemStylePlain target:nil action:nil]autorelease]; 
        
        anuleazaButton.tintColor = [UIColor blackColor];
        
        self.navigationItem.backBarButtonItem= anuleazaButton;  
        
          
        
        apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
    }
    return self;
}

-(void)salveazaAnunt
{/* NSNumber *adid = [row objectForKey:@"id"];
  NSNumber * latitude = [ row objectForKey:@"long"];///
  NSNumber * longitude = [row objectForKey:@"lat"];////
  CLLocationCoordinate2D coordinate;
  coordinate.latitude = latitude.doubleValue;
  coordinate.longitude = longitude.doubleValue; 
  NSString * name = [row objectForKey:@"name"];///
  NSString * description = [row objectForKey:@"ad_text"];///
  NSString * type = [row objectForKey:@"ad_type"];///
  NSString * propertyType = [row objectForKey:@"property_type"];////
  NSString * contactName = [row objectForKey:@"contact_name"];
  NSString * contactPhone = [row objectForKey:@"contact_phone"];
  NSString * contactEmail = [row objectForKey:@"contact_mail"];
  NSString * address = [row objectForKey:@"adress_line"];//
  NSString * judet = [row objectForKey:@"judet"];//
  NSString * oras = [row objectForKey:@"oras"];//
  NSNumber * price = [row objectForKey:@"pret"];///
  NSString * moneda = [row objectForKey:@"moneda"];///
  */
   
  
    

  //de pus un flag, daca oricare din campurile obligatorii sunt necompletate (sau nu are aleasa o locatie) sa apara un alerview cand se apasa "salveza" cu mesajul "datele anuntului sunt incomplete"  
    NSString *name = [NSString stringWithString:self.titluTextField.text];
    NSString *ad_temp_text = [NSString stringWithString:self.detaliiTextView.text];
    NSString *ad_text = [[ad_temp_text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "];
    NSString *pret = [NSString stringWithString:self.pretTextField.text];
    NSString *size = [NSString stringWithString:self.suprafataTextField.text];
    
    NSString *judet = [NSString stringWithString:self.judetTextField.text];
    NSString *oras = [NSString stringWithString:self.orasTextField.text];
    NSString *adress_line = [NSString stringWithString:self.adresaTextField.text];
    
    NSString *property_type =[NSString stringWithFormat:@"%@", [tableValues objectAtIndex:0]];
   
    
    NSString *latitude = [NSString stringWithFormat:@"%f", theNewAd.adlocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", theNewAd.adlocation.coordinate.longitude];
    
    NSString *publicat = @"NO";
    
    
    
    NSString *ad_type;
    if([self.tipAnuntSegmentedControl selectedSegmentIndex]==0)
    {ad_type = @"sale";} 
    else
    {ad_type = @"rent";}
    
    NSString *moneda;
    if([self.monedaSegmentedControl selectedSegmentIndex]==0)
    {moneda = @"lei";} 
    else
    {moneda = @"euro";}
    
   
    if(([self stringIsValid:name]==NO)||([self stringIsValid:ad_text]==NO)||([self stringIsValid:pret]==NO)||([self stringIsValid:size]==NO)||([self stringIsValid:judet]==NO)||([self stringIsValid:oras]==NO)||([self stringIsValid:adress_line]==NO)||([latitude intValue]==0)||([longitude intValue]==0)||[ad_text isEqualToString:@"Detalii anunt:"]||([self isNumeric:self.pretTextField.text]==NO)||([self isNumeric:self.suprafataTextField.text]==NO))
    {
        if([self isNumeric:self.pretTextField.text]==NO){self.pretTextField.text=@"";}
        if([self isNumeric:self.suprafataTextField.text]==NO){self.suprafataTextField.text=@"";}
        
        UIAlertView *atentionare = [[UIAlertView alloc] initWithTitle:@"Atentie" message:@"Datele anuntului sunt incomplete!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [atentionare show];
        [atentionare release];
    }
    
    else
    {
     NSDictionary *tempDictionary = [[[NSDictionary alloc] initWithObjectsAndKeys:name, @"name", ad_text, @"ad_text", ad_type, @"ad_type", pret, @"pret", size, @"size", moneda, @"moneda",latitude, @"lat", longitude, @"long", property_type, @"property_type",oras, @"oras", judet, @"judet", adress_line, @"adress_line", publicat, @"publicat", nil]autorelease];
        
        if(flagAnuntVechi==1)
            {int modificat= [theNewAd modifyAd:tempDictionary];
             NSLog(@"anunt vechi, modificat: %d", modificat);
                
            if(modificat==1){ 
                if([theNewAd.ad objectForKey:@"id"]!=nil)
                {
                    NSLog(@"Adaug id la AD. ID= %@",[theNewAd.ad objectForKey:@"id"]);
                    NSMutableDictionary * toSent = [NSMutableDictionary dictionaryWithDictionary:tempDictionary];
                    [toSent setObject:[theNewAd.ad objectForKey:@"id"] forKey:@"id"];
                    NSLog(@"mutable Dictionary with ID: %@", toSent);
                    tempDictionary = toSent;
                    NSLog(@"tempDictinary Dictionary with ID: %@", tempDictionary);
                }
                
                [theNewAd createAd:tempDictionary]; 
                NSLog(@"old ad with new dict:%@ ",theNewAd.ad);}
  
            }
        else{[theNewAd createAd:tempDictionary];
         NSLog(@"new ad with dict:%@ ",tempDictionary);
            [apdelegate.appSession.user.personalAds addAd:theNewAd];
        }    
    
   // NSLog(@"name from texfield: %@", name);
   // NSLog(@"name from ad: %@", [theNewAd.ad objectForKey:@"name"]);
   // NSLog(@"name from dictionary: %@", [tempDictionary objectForKey:@"name"]);
       
        
        //se adauga in lista doar daca e nou, altfel e deja in lista    
   
       
    ////
     if(theNewAd.imageList!=nil)
     {if([theNewAd.imageList count]>0)
     { 
         int d = [theNewAd.imageList indexOfDefaultImage];
         NSLog(@"index default:%d", d);
         CGSize thumbSize = CGSizeMake(75, 75);
         [theNewAd thumbnailWithTImage:[theNewAd.imageList getImageAtIndex:d] scaledToSize:thumbSize];
     }
         }
     ////                                   
        
     NSLog(@"%d",apdelegate.appSession.user.personalAds.count);
    
    [delegate performSelector:refreshMyAdsTable];  
    
    [self.navigationController popViewControllerAnimated:YES];
    }
 
}
-(BOOL) stringIsValid:(NSString *)string
{
    if([string isEqualToString:@""]){return NO;}
    
     
    NSMutableString *trimmedString = [NSMutableString stringWithString:string];
    trimmedString = (NSMutableString *)[trimmedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //NSLog(@"[After: %@]", trimmedString);    
    
   
    
    int length= trimmedString.length;
    
    if(length==0) {return NO;}    
    
    
    return YES;
}

-(BOOL) isNumeric:(NSString *)s
{
    NSScanner *sc = [NSScanner scannerWithString: s];
    if ( [sc scanFloat:NULL] )
    {
        return [sc isAtEnd];
    }
    return NO;
}


/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string { 
    NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0);
}
*/
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
    [theNewAd release];
    [orasTextField release];
    [judetTextField release];
    [adresaTextField release];
    
    
        
    [super dealloc];
    
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *) self.navigationItem.titleView;
    if(!titleView)
    {titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        if(flagAnuntVechi==1)
        {titleView.font = [UIFont boldSystemFontOfSize:14];
            titleView.textAlignment = UITextAlignmentLeft;}
        else{
        titleView.font = [UIFont boldSystemFontOfSize:20];
        }
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

-(IBAction)validateTextFiled:(UITextField *)textField
{
    if( [self isNumeric:textField.text]==NO)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"EROARE" message:@"Valoarea introdusa nu este un numar, completeaza din nou!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        textField.text=@"";
    }
    
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
    if([textView.text isEqualToString:@"Detalii anunt:"])
    {
    textView.text=@"";
    }
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

    if(theNewAd.imageList==nil){ [theNewAd initImageList];}/////
    
    AdaugaImaginiViewController *adaugaImaginiViewController = [[[AdaugaImaginiViewController alloc] initWithNibName:@"AdaugaImaginiViewController" bundle:nil]autorelease];
    
    adaugaImaginiViewController.tempAd = theNewAd;
    
    [self.navigationController pushViewController:adaugaImaginiViewController animated:YES];
    
}

- (IBAction)adaugaLocatie:(id)sender{
    
    LocalizareViewController *adaugaLocatieViewController = [[[LocalizareViewController alloc] initWithNibName:@"LocalizareViewController" bundle:nil]autorelease];
    
    adaugaLocatieViewController.tempAd=theNewAd;
    adaugaLocatieViewController.delegate = self;
    adaugaLocatieViewController.geocoder = @selector(reverseGeocoding);
    
    [self.navigationController pushViewController:adaugaLocatieViewController animated:YES];
    
}

-(void) reverseGeocoding
{
    CLLocation *location = [[[CLLocation alloc] initWithLatitude:theNewAd.adlocation.coordinate.latitude longitude:theNewAd.adlocation.coordinate.longitude] autorelease];
    CLGeocoder * geocoder = [[[CLGeocoder alloc] init]autorelease];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark * placemark = [placemarks objectAtIndex:0];
        
        NSString * formattedAddressLines = [[[placemark addressDictionary]objectForKey:@"FormattedAddressLines"]objectAtIndex:0]; 
        NSString * a = [[[NSString alloc] initWithData:[formattedAddressLines dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding] autorelease];
        NSLog(@"Adresa: %@", a);
        
        NSString *locality = [[placemark addressDictionary]objectForKey:@"SubLocality"];
        NSString * b = [[[NSString alloc] initWithData:[locality dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding] autorelease];
        NSLog(@"Localitate: %@", b);
        
        NSString * state = [[placemark addressDictionary]objectForKey:@"State"];
        NSString * c = [[[NSString alloc] initWithData:[state dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding] autorelease];
        NSLog(@"Judet: %@", c);
        
        //[tempAd.ad setObject:a forKey:@"adress_line"];
        //[tempAd.ad setObject:b forKey:@"oras"];
        //[tempAd.ad setObject:c forKey:@"judet"];
        if([c isEqualToString:@"Bucharest"])
        {c=@"Bucuresti";}
        
        [self.orasTextField setEnabled:YES];
        [self.judetTextField setEnabled:YES];
        [self.adresaTextField setEnabled:YES];
        self.orasTextField.backgroundColor = [UIColor whiteColor];
        self.judetTextField.backgroundColor = [UIColor whiteColor];
        self.adresaTextField.backgroundColor = [UIColor whiteColor];
        
        adresaTextField.text = a;
        orasTextField.text = b;
        judetTextField.text = c;
    }];
    
    
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
    cell.textLabel.font =[UIFont fontWithName:@"Helvetica" size:16]; 
    
    cell.detailTextLabel.text = [ tableValues objectAtIndex:[indexPath row]];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    
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
    pickerView.frame = CGRectMake(0, 100, 320, 216);
    [menu addSubview:pickerView];
    
    //[pickerView release];
    [menu release];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //return 2;
    return 1;
    
}
/*
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
  if(component == tipImobil)
      return 230;
    return 70;
}
*/

-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    /*
    if(component == tipImobil)
    {return [propertyTypes count];}
    
    if(component == nrCamere)
    {return  [camere count];}
            
    return 0;
     */
    if(component == tipImobil)
    {return [propertyTypes count];}
    return 0;

}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == tipImobil)
    {   return [propertyTypes objectAtIndex:row];}
    /*
    if (component == nrCamere)
    { return [camere objectAtIndex:row];}
    */
    return 0;
}

-(void) pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString * imobil = [propertyTypes objectAtIndex:[thePickerView selectedRowInComponent:0]];
   // NSString * rooms = [camere objectAtIndex:[thePickerView selectedRowInComponent:1]];
   // NSLog(@"Tip imobil: %@, %@ camere", imobil,rooms);
    [tableValues replaceObjectAtIndex:0 withObject:imobil];
    //[tableValues replaceObjectAtIndex:1 withObject:rooms];
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

-(void) atentionareStergereAnunt
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atentie" message:@"Anuntul se va sterge definitv. Continuati?" delegate:self cancelButtonTitle:@"NU" otherButtonTitles:@"DA", nil];
    [alert show];
    [alert release];
}
-(void) stergeAnunt
{   //verificare daca e in global ad list si fav? si stergere si de acolo
    
    
    //request de stergere de pe server - metoda din user
    [apdelegate.appSession.user removeMyAd:theNewAd];
    
    //[apdelegate.appSession.user.personalAds removeAd:theNewAd];
    [delegate performSelector:refreshMyAdsTable];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
       {
           
       }
    else
    {
        NSLog(@"Stergere");
        [self stergeAnunt];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.pretTextField.delegate = self;
    //self.suprafataTextField.delegate = self;
    
    
    if(theNewAd==nil)
    {theNewAd = [TAd alloc];
     flagAnuntVechi=0;   
        [self setTitle:@"Adauga anunt"];
        self.navigationItem.rightBarButtonItem =  [[[UIBarButtonItem alloc] initWithTitle:@"Salveaza" style:UIBarButtonItemStylePlain target:self action:@selector(salveazaAnunt)]autorelease]; 
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
        
        
        
        [self.orasTextField setEnabled:NO];
        [self.judetTextField setEnabled:NO];
        [self.adresaTextField setEnabled:NO];
        self.orasTextField.backgroundColor = [UIColor grayColor];
        self.judetTextField.backgroundColor = [UIColor grayColor];
        self.adresaTextField.backgroundColor = [UIColor grayColor];    
        
        tableValues = [[NSMutableArray alloc] initWithObjects:@"Garsoniera", nil];
    }
    else
    {   flagAnuntVechi=1;
        [self setTitle:@"Editeaza anunt"];
        // labels with infos
        self.titluTextField.text = [theNewAd.ad objectForKey:@"name"];
        if([[theNewAd.ad objectForKey:@"ad_type"] isEqualToString:@"sale"])
        { self.tipAnuntSegmentedControl.selectedSegmentIndex=0;}
        else
        {self.tipAnuntSegmentedControl.selectedSegmentIndex=1;} 
        self.pretTextField.text=[theNewAd.ad objectForKey:@"pret"];
    
        if([[theNewAd.ad objectForKey:@"moneda"] isEqualToString:@"lei"])
        { self.monedaSegmentedControl.selectedSegmentIndex=0;}
        else
        {self.monedaSegmentedControl.selectedSegmentIndex=1;} 
        
        self.suprafataTextField.text = [theNewAd.ad objectForKey:@"size"];
        self.orasTextField.text = [theNewAd.ad objectForKey:@"oras"];
        self.judetTextField.text = [theNewAd.ad objectForKey:@"judet"];
        self.adresaTextField.text = [theNewAd.ad objectForKey:@"adress_line"];
        self.detaliiTextView.text = [theNewAd.ad objectForKey:@"ad_text"];
        tableValues = [[NSMutableArray alloc]  initWithObjects:[theNewAd.ad objectForKey:@"property_type"],nil];
        
        
        UIBarButtonItem *salveazaButton =[[[UIBarButtonItem alloc] initWithTitle:@"Salveaza" style:UIBarButtonItemStylePlain target:self action:@selector(salveazaAnunt)]autorelease]; 
        salveazaButton.tintColor =[UIColor blackColor];        
        
        UIBarButtonItem *stergeButton = [[[UIBarButtonItem alloc] initWithTitle:@"Sterge" style:UIBarButtonItemStylePlain target:self action:@selector(atentionareStergereAnunt)]autorelease];
        stergeButton.tintColor= [UIColor blackColor];
        
        NSArray *buttonsArray = [NSArray arrayWithObjects:stergeButton,salveazaButton,nil];
        self.navigationItem.rightBarButtonItems = buttonsArray;
        
       }
    
    //selectedPropType = nil;
    tableItems = [[NSMutableArray alloc] initWithObjects:@"Tip Imobil", nil];

    
    
    pickerView = [[UIPickerView alloc] init];
    pickerView.showsSelectionIndicator = YES;
    pickerView.delegate=self ;
    pickerView.dataSource = self;
    
    propertyTypes = [[NSMutableArray alloc] init];
    [propertyTypes addObject:@"Garsoniera"];
    [propertyTypes addObject:@"Apartament 2 camere"];
    [propertyTypes addObject:@"Apartament 3 camere"];
    [propertyTypes addObject:@"Apartament 4 camere"];
    //[propertyTypes addObject:@"Apartament 5+ camere"];
    [propertyTypes addObject:@"Casa"];
    //[propertyTypes addObject:@"Spatiu Comercial"];
   
    /* 
    camere = [[NSMutableArray alloc] init];
    [camere addObject:@"0"];
    [camere addObject:@"1"];
    [camere addObject:@"2"];
    [camere addObject:@"3"];
    [camere addObject:@"4"];
    [camere addObject:@"5+"];
  */  
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
