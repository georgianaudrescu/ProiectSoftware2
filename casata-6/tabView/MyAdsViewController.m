//
//  MyAdsViewController.m
//  casata
//
//  Created by Oana B on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyAdsViewController.h"
#import "AppDelegate.h"

#define ALPHA                   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define NUMERIC                 @"1234567890"
#define ALPHA_NUMERIC           ALPHA NUMERIC

@implementation MyAdsViewController
@synthesize tableAds;
@synthesize headerView,dateContact, headerDateContact,scrollView, headerLabel;
@synthesize userName, phone, email;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backToStatistics{
    
    //for animation
    //pozitia de plecare
    self.view.frame = CGRectMake(0,0, 320, 460);
    //pozitia finala
    [UIView animateWithDuration:0.5 
                     animations:^{self.view.frame = CGRectMake(-320,0, 320, 460);}
                     completion:^(BOOL completed){[self.view removeFromSuperview];}];
    
    
    
}

- (void)openDateContact
{
    if( tapHeader == 0)
    {
        self.dateContact.frame = CGRectMake(0, 367, 320, 220);
        [UIView animateWithDuration:0.5 animations:^{self.dateContact.frame=CGRectMake(0, 197, 320, 220);}];
        [tableAds setUserInteractionEnabled:NO];
        tapHeader =1;
    
    }
    else if(tapHeader == 1)
    {
        self.dateContact.frame = CGRectMake(0, 197, 320, 220);
        [UIView animateWithDuration:0.5 animations:^{self.dateContact.frame=CGRectMake(0, 367, 320, 220);}];
        [tableAds setUserInteractionEnabled:YES];
        tapHeader =0;
    }
}

-(IBAction)salveazaDateContact:(id)sender
{
    if(([self validateTextField:phone]&&[self validateTextField:email])&&(userName.text !=@""))
    {
        apdelegate.appSession.user.username = userName.text;
        apdelegate.appSession.user.phone = phone.text;
        apdelegate.appSession.user.email  = email.text;
        tapHeader =1;
        [ self openDateContact];
        NSLog(@"user: %@, %@, %@", apdelegate.appSession.user.username,apdelegate.appSession.user.phone,apdelegate.appSession.user.email);  
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"EROARE" message:@"Date de contact invalide" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (BOOL) validateTextField:(UITextField *)textFiled
{
    if (textFiled.tag == 1001)
    {
        // email validation
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
        //NSLog(@"%@",[emailTest evaluateWithObject:textFiled.text]);
        return [emailTest evaluateWithObject:textFiled.text];
    }
    else if (textFiled.tag ==1002)
    {
        //phone validation
        NSString *phoneRegex = @"^+(?:[0-9] ?){9}[0-9]$"; 
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex]; 
        
        return [phoneTest evaluateWithObject:textFiled.text];
    }
    return YES;
}

-(IBAction) textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    
        [self animateTextField: textField up: YES];

}


- (IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self validateTextField:textField]) {
    [self animateTextField: textField up: NO];
}
    else {
        if (textField.tag == 1001){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"EROARE" message:@"Email invalid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        }
        else if (textField.tag == 1002){
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"EROARE" message:@"Telefon invalid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        [self animateTextField:textField up:NO];
    }
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
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
-(void) refreshMyAdsTable
{
    [self.tableAds reloadData];
    int nrAnunt = [apdelegate.appSession.user.personalAds count];
    if(nrAnunt==1)
    {self.headerLabel.text =[NSString stringWithFormat:@"%d anunt", nrAnunt];}
    else
    {self.headerLabel.text =[NSString stringWithFormat:@"%d anunturi", nrAnunt];}
}
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//return [propertyTypes count];
    //return 10;
    if ([apdelegate.appSession.user.personalAds count] ==0)
        return 1;
    return [apdelegate.appSession.user.personalAds count] ;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    TAd *tempAd;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self
			   action:@selector(publicaAnunt:)
	 forControlEvents:UIControlEventTouchDown];
	[button setTitle:@"Publica" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	button.frame = CGRectMake(240.0f, 5.0f, 70.0f, 30.0f);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
        cell.imageView.image = [UIImage imageNamed:@"house.jpg"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChecking:)];
    [cell.imageView addGestureRecognizer:tap];
    [tap release];
    
    //cell.textLabel.text = [ propertyTypes objectAtIndex:[indexPath row]];
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor blackColor];
    
    cell.selectedBackgroundView = backgroundView;
    [backgroundView release];
    
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    if ([apdelegate.appSession.user.personalAds count] == 0)
    {
        cell.textLabel.text = @"Nu exita anunturi in lista";
    }
    else
    {
        tempAd = [apdelegate.appSession.user.personalAds getAdAtIndex:[indexPath row]];
        NSString *titlu = [tempAd.ad objectForKey:@"name"];
        //tempAd=nil;
        cell.textLabel.text = titlu;
        NSLog(@"%@",titlu);
        NSLog(@"%d",[indexPath row]);
        
        //acest buton va fi numai in randurile in care anunturile au fost modificate...
        if(tempAd.uploaded == NO)
        {
            button.tag=[indexPath row];
            [cell addSubview:button];
        }
    }
    
	
    

    return cell;
}

-(void) publicaAnunt:(UIButton*)sender{
    //se publica anuntul selectat din lista
    NSLog(@"Se publica anuntul selectat");
    [apdelegate.appSession.user uploadAd:sender.tag];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
      
    
    // headerView
    headerView.frame = CGRectMake(0, 0, 320, 50);
    [self.view addSubview:headerView];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backToStatistics)];
    swipeLeft.numberOfTouchesRequired=1;
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.headerView addGestureRecognizer:swipeLeft]; 
    [swipeLeft release];
    
    //ScrollView
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 50, 320, 460);
    scrollView.pagingEnabled=YES;
    [self.view addSubview:scrollView];
    
    [self.scrollView setContentSize:CGSizeMake(320, 630)];
    
    //tableView size
    [self.scrollView addSubview:tableAds];
    tableAds.frame = CGRectMake(0, 0, 320, 310);
    
    
    //date de contact adaugat ca subview
    [self.scrollView addSubview:dateContact]; 
    dateContact.frame = CGRectMake(0, 317, 320, 220);
    
    email.tag = 1001;
    phone.tag = 1002;
    tapHeader = 0;
    
    // apdelegate pentru actualizare user info
    apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(apdelegate.appSession.user !=nil)
    {
        userName.text = apdelegate.appSession.user.username;
        phone.text = apdelegate.appSession.user.phone;
        email.text = apdelegate.appSession.user.email;
    }
    
     [self refreshMyAdsTable];
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
-(void) dealloc
{
    [tableAds release];
    [headerView release];
    [dateContact release];
    [headerDateContact release];
    [userName release];
    [phone release];
    [email release];
    [scrollView release];
    [headerLabel release];
    [super dealloc];

}

@end
