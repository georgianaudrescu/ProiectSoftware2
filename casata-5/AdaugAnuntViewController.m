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
@synthesize pretTextField,suprafataTextField,tableImobil,titluTextField,camereTextField,detaliiTextView, scrollView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // self.title = NSLocalizedString(@"Adauga anunt", @"Adauga anunt");
       // self.tabBarItem.image = [UIImage imageNamed:@"adauga_anunt"];
       [self setTitle:@"Adauga anunt"];
        //butonul care va aparea ca back button pt view-ul child care va fi pus in stiva peste view-ul curent
        UIBarButtonItem *anuleazaButton = [[UIBarButtonItem alloc] initWithTitle:@"Anuleaza" style:UIBarButtonItemStylePlain target:nil action:nil]; 
        
        anuleazaButton.tintColor = [UIColor blackColor];
        
        self.navigationItem.backBarButtonItem= anuleazaButton;  
        
    }
    return self;
}



-(void)dealloc
{
    [titluTextField release];
    [pretTextField release];
    [suprafataTextField release];
    [pretTextField release];
    [detaliiTextView release];
    [camereTextField release];
    [scrollView release];
    [tableImobil release];
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
    [suprafataTextField resignFirstResponder];
    [pretTextField resignFirstResponder];
    [titluTextField resignFirstResponder];
    [detaliiTextView resignFirstResponder];
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (IBAction)textFieldDidEndEditing:(UITextField *)textField
{
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
    [self animateTextView: textView up: YES];
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
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

    AdaugaImaginiViewController *adaugaImaginiViewController = [[[AdaugaImaginiViewController alloc] initWithNibName:@"AdaugaImaginiViewController" bundle:nil]autorelease];
    
    [self.navigationController pushViewController:adaugaImaginiViewController animated:YES];
    
}

- (IBAction)adaugaLocatie:(id)sender{
    
    LocalizareViewController *adaugaLocatieViewController = [[[LocalizareViewController alloc] initWithNibName:@"LocalizareViewController" bundle:nil]autorelease];
    
    [self.navigationController pushViewController:adaugaLocatieViewController animated:YES];
    
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];;
    }
        if ([selectedPropType isEqual:[propertyTypes objectAtIndex:indexPath.row]]) {
        cell.imageView.image = [UIImage imageNamed:@"checkbox_ticked.png"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"checkbox_not_ticked.png"];
    }
    
    cell.textLabel.text = [ propertyTypes objectAtIndex:[indexPath row]];
    //  return cell;

    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor blackColor];
    
    cell.selectedBackgroundView = backgroundView;
    [backgroundView release];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {   

    UITableViewCell *cell = [tableImobil cellForRowAtIndexPath:indexPath];
    
    if([selectedPropType isEqual:[propertyTypes objectAtIndex:indexPath.row]])
    {
        cell.imageView.image = [UIImage imageNamed:@"checkbox_not_ticked.png"];
        selectedPropType  =nil;
    }
    else
    {
        selectedPropType=nil;
        [tableImobil reloadData];
        cell.imageView.image = [UIImage imageNamed:@"checkbox_ticked.png"];
        selectedPropType  =cell.textLabel.text;
        selectedIndex = indexPath;
    }
    NSLog(@"%@",selectedPropType);
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor blackColor];
    
    cell.selectedBackgroundView = backgroundView;
    [backgroundView release];


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
    
    selectedPropType = nil;
    
    propertyTypes = [[NSMutableArray alloc] init];
    [propertyTypes addObject:@"Garsoniera"];
    [propertyTypes addObject:@"Apartament"];
    [propertyTypes addObject:@"Casa"];
    [propertyTypes addObject:@"Spatiu Comercial"];
    
    detaliiTextView.delegate = self;
    
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
