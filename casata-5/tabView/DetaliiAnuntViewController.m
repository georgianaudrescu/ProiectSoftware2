//
//  DetaliiAnuntViewController.m
//  casata
//
//  Created by me on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetaliiAnuntViewController.h"
#import "AppDelegate.h"
#import "TImage.h"
#import "TImageList.h"

@implementation DetaliiAnuntViewController
@synthesize theAd;
@synthesize pretLabel, propertyTypeLabel, monedaLabel, contactNameLabel, contactPhoneLabel, adTextLabel, adressLineLabel,nameLabel, anuntTypeLabel;
@synthesize thumbnailImageView;
@synthesize imgView, imgScrollView,buttonsArray, imgList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        //[self setTitle:@"Detalii anunt"];
        buttonsArray = [[NSMutableArray alloc]init];
        
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
    self.adTextLabel.text = [NSString stringWithFormat:@"Descriere:  %@", [self.theAd.ad objectForKey:@"ad_text"]];
    self.adressLineLabel.text = [NSString stringWithFormat:@"Adresa:  %@", [self.theAd.ad objectForKey:@"adress_line"]];
    NSNumber *pret = [self.theAd.ad objectForKey:@"pret"];
    
    self.pretLabel.text = [NSString stringWithFormat:@"%d %@",pret.intValue, [self.theAd.ad objectForKey:@"moneda"]];
   
    self.contactNameLabel.text = [self.theAd.ad objectForKey:@"contact_name"];
    self.contactPhoneLabel.text = [self.theAd.ad objectForKey:@"contact_phone"];
    self.anuntTypeLabel.text = [self.theAd.ad objectForKey:@"ad_type"];
    
    self.thumbnailImageView.image = [UIImage imageNamed:@"house.jpg"];

   
    if([[self.theAd.ad objectForKey:@"adress_line"] length] <=24)
    {[self.adressLineLabel sizeToFit];
        self.adressLineLabel.frame = CGRectMake(20, 346, 281, self.adressLineLabel.frame.size.height);
       
    }
    
    if([[self.theAd.ad objectForKey:@"ad_text"] length] <=24)
    {[self.adTextLabel sizeToFit];
     self.adTextLabel.frame = CGRectMake(20, 298, 280, self.adTextLabel.frame.size.height);
    }
    
    
    
    //test thumnails in scrollview de unde sa selectezi ce sa-ti apara in imageview
    self.imgList = [[TImageList alloc] init];
    TImage *img1 = [TImage alloc];
    [img1 initWithImage:[UIImage imageNamed:@"imgtest1.jpg"]];
    
    [self.imgList addImage:img1];
    [img1 release];
    TImage *img2 = [TImage alloc];
    [img2 initWithImage:[UIImage imageNamed:@"imgtest2.jpg"]];
    
    [self.imgList addImage:img2];
    [img2 release];
    TImage *img3 = [TImage alloc];
    [img3 initWithImage:[UIImage imageNamed:@"imgtest3.jpg"]];
    
    [self.imgList addImage:img3];
    [img3 release];
    TImage *img4 = [TImage alloc];
    [img4 initWithImage:[UIImage imageNamed:@"imgtest4.jpg"]];
    
    [self.imgList addImage:img4];
    [img4 release];
   
        
    
    int nr=4;
    int start;
    for(int x=0;x<nr;x++)
    {
        //daca sunt mai putin de 7 imagini, nu depasesc latimea scrolview-ului si ar fi ideal sa fie aliniate central, de aceea aflam o pozitie de start
        if(nr<=6)
        start = (300 - nr*50)/2;
        else start=0;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(start+(x*50), 0, 50, 50)];
        button.tag=x;
        [button addTarget:self action:@selector(changeCurrentViewedImageToImageWithIndex:) forControlEvents:UIControlEventTouchUpInside];
        // 
        TImage *theImag =  [self.imgList getImageAtIndex:x];
        UIImage *butImage = theImag.image;
        if(x==0)self.imgView.image = theImag.image;
        theImag=nil;
        //
        [button setBackgroundImage:butImage forState:UIControlStateNormal];
        [butImage release];
        
        [self.buttonsArray addObject:button];
        [self.imgScrollView addSubview:[self.buttonsArray objectAtIndex:x]];
        
        
    }       
    
    if(nr<=6)
        self.imgScrollView.contentSize = CGSizeMake(300, 50);
    else
        self.imgScrollView.contentSize = CGSizeMake(nr*50, 50);
    
    
}

-(void) changeCurrentViewedImageToImageWithIndex:(id) sender
{
    UIButton *senderButton = (UIButton*)sender;
    
    NSLog(@"buton tag: %d", senderButton.tag);
     int x =senderButton.tag;
      TImage *theImag =  [self.imgList getImageAtIndex:x];
      self.imgView.image=theImag.image;
      theImag=nil;
    
    
       //self.imgView.image = [UIImage imageNamed:@"imgtest1.jpg"];
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
    [imgView release];
    [imgScrollView release];
    [buttonsArray release];
    [imgList release]; 
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
