//
//  DetaliiAnuntViewController.m
//  casata
//
//  Created by me on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetaliiAnuntViewController.h"
#import "AppDelegate.h"

@implementation DetaliiAnuntViewController
@synthesize theAd;
@synthesize pretLabel, propertyTypeLabel, monedaLabel, contactNameLabel, contactPhoneLabel, adTextLabel, adressLineLabel,nameLabel, anuntTypeLabel;
@synthesize thumbnailImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        //[self setTitle:@"Detalii anunt"];
        
    }
    return self;
}

/*
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
 */

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)loadAdWithId:(int)theAdId
{
    self.theAd = [apdelegate.appSession.globalAdList getAdWithId:theAdId];
    
   
    
    
    NSLog(@"Judetul ad-ului selectat:%@", [self.theAd.ad objectForKey:@"judet"]);
    
    self.nameLabel.text = [self.theAd.ad objectForKey:@"name"];
    self.propertyTypeLabel.text =[self.theAd.ad objectForKey:@"property_type"];
    self.adTextLabel.text = [self.theAd.ad objectForKey:@"ad_text"];
    self.adressLineLabel.text = [self.theAd.ad objectForKey:@"adress_line"];
    NSNumber *pret = [self.theAd.ad objectForKey:@"pret"];
    
    self.pretLabel.text = [NSString stringWithFormat:@"%d %@",pret.intValue, [self.theAd.ad objectForKey:@"moneda"]];
    self.monedaLabel.text = [self.theAd.ad objectForKey:@"moneda"];//
    self.contactNameLabel.text = [self.theAd.ad objectForKey:@"contact_name"];
    self.contactPhoneLabel.text = [self.theAd.ad objectForKey:@"contact_phone"];
    self.anuntTypeLabel.text = [self.theAd.ad objectForKey:@"ad_type"];
    
    self.thumbnailImageView.image = [UIImage imageNamed:@"house.jpg"];
    
    
    
    //theAd =nil;///////
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) dealloc
{ 
    [theAd release];
    
    [nameLabel release];
    [propertyTypeLabel release];
    [contactPhoneLabel release];
    [contactNameLabel release];
    [monedaLabel release];
    [adressLineLabel release];
    [adTextLabel release];
    [pretLabel release];
    [anuntTypeLabel release];
    [thumbnailImageView release];

    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
