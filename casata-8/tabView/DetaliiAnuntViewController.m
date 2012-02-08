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
@synthesize pretLabel, propertyTypeLabel, monedaLabel, contactNameLabel, contactPhoneLabel, adTextLabel, adressLineLabel,nameLabel, anuntTypeLabel, favButton, contactEmailLabel,propertySize;
@synthesize thumbnailImageView;
@synthesize imgView, imgScrollView,imageViewsArray, imgList;
@synthesize delegate, hidePinIfRemovedFromFav; //pt a seta map ca delegate
//@synthesize popView, popViewContact; 
@synthesize bigScroll, adTextView;
@synthesize callButton;
@synthesize headerView, imaginiView, detaliiView, contactView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        //[self setTitle:@"Detalii anunt"];
        imageViewsArray = [[NSMutableArray alloc]init];
        
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

-(void)loadAdWithId:(int)theAdId internetActive:(BOOL)internetIsActive
{
    //[self.imageViewsArray release];
    //self.imageViewsArray = [[NSMutableArray alloc]init];
    
    self.theAd = [apdelegate.appSession.globalAdList getAdWithId:theAdId];
    NSLog(@"adresa din mem a rezultatului%@", self.theAd);
    
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.bigScroll setContentOffset:CGPointMake(0, 0)];
    
    
   // NSLog(@"Judetul ad-ului selectat:%@", [self.theAd.ad objectForKey:@"judet"]);
    
    //punerea textului anuntului in label-urile corespunzatoare
    self.nameLabel.text = [self.theAd.ad objectForKey:@"name"];
    self.propertyTypeLabel.text =[self.theAd.ad objectForKey:@"property_type"];
    //self.adTextLabel.text = [NSString stringWithFormat:@"Descriere:  %@", [self.theAd.ad objectForKey:@"ad_text"]];
    self.adressLineLabel.text = [self.theAd.ad objectForKey:@"adress_line"];
    //---NSNumber *pret = [self.theAd.ad objectForKey:@"pret"];
    
    self.pretLabel.text = [NSString stringWithFormat:@"%d %@",[[self.theAd.ad objectForKey:@"pret"] intValue], [self.theAd.ad objectForKey:@"moneda"]];
   
    self.contactNameLabel.text = [self.theAd.ad objectForKey:@"contact_name"];
    self.contactEmailLabel.text = [self.theAd.ad objectForKey:@"contact_mail"];
    NSLog(@"email: %@", [self.theAd.ad objectForKey:@"contact_mail"]);
    self.contactPhoneLabel.text = [self.theAd.ad objectForKey:@"contact_phone"];
    self.anuntTypeLabel.text = [self.theAd.ad objectForKey:@"ad_type"];
    self.propertySize.text = [NSString stringWithFormat:@"%@ mp", [self.theAd.ad objectForKey:@"size"]];
    
    self.thumbnailImageView.image = [UIImage imageNamed:@"thumbAnuntDefault.png"];
    
    NSString *proptyp;
    if ([[self.theAd.ad objectForKey:@"ad_type"] isEqual:@"sell"])
    {
        proptyp =@"vanzare";
        
    } 
    if ([[self.theAd.ad objectForKey:@"ad_type"] isEqual:@"rent"])
    {
        proptyp =@"inchiriere";
    }
    self.anuntTypeLabel.text = proptyp;
    //self.anuntTypeLabel.text = [self.theAd.ad objectForKey:@"ad_type"];
    
    
    
    
    /// detalii text in textview:
    self.adTextView .delegate = self;
    self.adTextView.text = [self.theAd.ad objectForKey:@"ad_text"];
    self.adTextView.editable = NO;
    
    //verificare daca este favorit sau nu si setarea imaginii pt butonul de adaugare/inlaturare din favorite in functie de asta
    if(apdelegate.appSession.user.favorites.count !=0) 
        
    {   NSLog(@"avem favorite");
        TAd *testAd = [apdelegate.appSession.user.favorites getAdWithId:theAdId];
        if (testAd==nil)
        {
            NSLog(@"si nu este favorit");
            [self.favButton setImage:[UIImage imageNamed:@"starfavDeactivat.png"] forState:UIControlStateNormal];
            //[self.favButton setBackgroundImage:[UIImage imageNamed:@"starfavDeactivat.png"] forState:UIControlStateNormal];
            self.favButton.tag=0;

        }
        else 
        {
            NSLog(@"si este favorit");
        [self.favButton setImage:[UIImage imageNamed:@"starfav.png"] forState:UIControlStateNormal];
            self.favButton.tag=1;
        }
    }  
        
    else //nu exista favorite in lista si nu are rost sa verificam
    {  NSLog(@"nu avem favorite");
        [self.favButton setImage:[UIImage imageNamed:@"starfavDeactivat.png"] forState:UIControlStateNormal];
        self.favButton.tag=0;
    }
      
    //clear old images from scrollView
    if(self.imageViewsArray.count>0)
    {
        for(UIView *view in self.imgScrollView.subviews)
        { [view removeFromSuperview];
        }
        //[self.imgScrollView setNeedsDisplay];
        [self.imageViewsArray removeAllObjects];
    }
    
    self.imgScrollView.contentSize = CGSizeMake(300, 230);
    ////
    
    
    //get images or put default imag
    
    int nrImagini = [[self.theAd.ad objectForKey:@"num_pic"] intValue];
    NSLog(@"numar imagini:%d", nrImagini);
    int idul = [[self.theAd.ad objectForKey:@"id"] intValue];
    if(nrImagini!=0)
    {
    if(self.theAd.imageList == nil)
    {
        if(internetIsActive==YES)//avem conexiune
        {
        [self.theAd initImageList];
        
        
        int d = [[self.theAd.ad objectForKey:@"main_pic"] intValue];
        
        // NSLog(@"index default:%d", d);
         CGSize thumbSize = CGSizeMake(101, 92);
        TImage *thumbImag = [TImage alloc];
        [thumbImag initWithImageFromUrlString:[NSString stringWithFormat:@"http://unicode.ro/imobiliare/images/%d_%d_th.jpg",idul, d]];   
        
        NSLog(@"thumbnail url:%@", [thumbImag.url absoluteString]);
        
         [self.theAd thumbnailWithTImage:thumbImag scaledToSize:thumbSize];
        ///[thumbImag release];
        thumbImag=nil; 
            
         //self.thumbnailImageView.image = self.theAd.thumb.image;//       
        
        for(int i=1;i<=nrImagini;i++)
        {
            
            TImage *img1 = [TImage alloc];
            [img1 initWithImageFromUrlString:[NSString stringWithFormat:@"http://unicode.ro/imobiliare/images/%d_%d.jpg",idul,i]];
             
            if(i==d)//daca este imaginea default, retinem asta
            {img1.defaultValue=1;}
            else
            {img1.defaultValue=0;}
            img1.name=@"";
            [self.theAd.imageList addImage:img1];
            //[img1 release];
            img1=nil;
        }
        }
        else
        {
            //imagine default
            UIImageView *imageView = [[[UIImageView alloc] init] autorelease];
            imageView.frame= CGRectMake(0, 0, 300, 230);
            imageView.contentMode = UIViewContentModeCenter;   
            
            imageView.image = [UIImage imageNamed:@"bigAnuntDefault.png"];
            
            [self.imageViewsArray addObject:imageView];
            [self.imgScrollView addSubview:[self.imageViewsArray objectAtIndex:0]];
        
        }
    }
    
    
        
  if(self.theAd.imageList!=nil)
  {     
   
  self.thumbnailImageView.image = self.theAd.thumb.image;//    
      
    for(int x=0;x<nrImagini;x++)
    {
        //daca sunt mai putin de 7 imagini, nu depasesc latimea scrolview-ului si ar fi ideal sa fie aliniate central, de aceea aflam o pozitie de start
        /* if(nr<=6)
         start = (300 - nr*50)/2;
         else  start=0; */
        
        // UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImageView *imageView = [[[UIImageView alloc] init] autorelease];
        imageView.frame= CGRectMake((x*300), 0, 300, 230);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        // 
        TImage *theImag =  [self.theAd.imageList getImageAtIndex:x];
        NSLog(@"mem adress of image:%@", theImag);
        UIImage *butImage = theImag.image;
        
        
        theImag=nil;
        //
        imageView.image = butImage;
        //[butImage release];
        
        [self.imageViewsArray addObject:imageView];
        [self.imgScrollView addSubview:[self.imageViewsArray objectAtIndex:x]];
        
        
    }       
    
    
    self.imgScrollView.contentSize = CGSizeMake(nrImagini*300, 230);
    [self.imgScrollView setPagingEnabled:YES];
    [self.imgScrollView setBounces:NO];
  }
    }   
    else
    {
    //imagine default
        UIImageView *imageView = [[[UIImageView alloc] init] autorelease];
        imageView.frame= CGRectMake(0, 0, 300, 230);
        imageView.contentMode = UIViewContentModeCenter;   
        
        imageView.image = [UIImage imageNamed:@"bigAnuntDefault.png"];
        
        [self.imageViewsArray addObject:imageView];
        [self.imgScrollView addSubview:[self.imageViewsArray objectAtIndex:0]];
        
    }
    
}

/*-(void) changeCurrentViewedImageToImageWithIndex:(id) sender
{
    UIButton *senderButton = (UIButton*)sender;
    
    NSLog(@"buton tag: %d", senderButton.tag);
     int x =senderButton.tag;
      TImage *theImag =  [self.imgList getImageAtIndex:x];
      self.imgView.image=theImag.image;
      theImag=nil;
    
    
       //self.imgView.image = [UIImage imageNamed:@"imgtest1.jpg"];
}
*/
-(IBAction)favButtonPressed:(UIButton*)sender
{
    if(sender.tag==0) //adaugam in favorite 
    {
        if(apdelegate.appSession.user.favorites.count <20) //adauga doar daca nu a depasit nr maxim de favorite
        {
        NSLog(@"add to fav:");
        [apdelegate.appSession.user.favorites addAd:self.theAd];
        sender.tag=1;
       [sender setImage:[UIImage imageNamed:@"starfav.png"] forState:UIControlStateNormal];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Nu poti salva mai mult de 20 de anunturi ca favorite." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            [alertView release];        }
    }
    else //stergem din favorite
    {
        NSLog(@"remove from fav");
        [apdelegate.appSession.user.favorites removeAd:self.theAd];
        sender.tag=0;
        [sender setImage:[UIImage imageNamed:@"starfavDeactivat.png"] forState:UIControlStateNormal];
        [delegate performSelector:hidePinIfRemovedFromFav];
    }
    
    

}

-(IBAction)detaliiButtonPressed:(id)sender{
    [self.bigScroll setContentOffset:CGPointMake(0, 315) animated:YES];
    
}
-(IBAction)upToImg:(id)sender{
    [self.bigScroll setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(IBAction)contactButtonPressed:(id)sender{
    [self.bigScroll setContentOffset:CGPointMake(0, 630) animated:YES];
}

-(IBAction)callOwner:(UIButton*)sender
{
    NSString *deviceType = [UIDevice currentDevice].model;
    NSLog(@"device: %@", deviceType);
    
    if([deviceType isEqualToString:@"iPhone"])
    {
        NSString * callString = [NSString  stringWithFormat:@"tel:%@", [self.theAd.ad objectForKey:@"contact_phone"]];
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callString]];
        
            
            //NSURL *phoneNumber = [[NSURL alloc] initWithString: @"tel:867-5309"];
            //[[UIApplication sharedApplication] openURL: phoneNumber];

    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Atentie!" message:@"Functionalitate disponibila numai pentru iPhone!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.imgScrollView.frame = CGRectMake(10, 180, 300, 200);    
    
    self.headerView.frame = CGRectMake(0, 0, 320, 100);
    [self.view addSubview:self.headerView];
    
    self.bigScroll.frame = CGRectMake(0, 100, 320, 360); //360
    [self.bigScroll setPagingEnabled:YES];
    [self.bigScroll setScrollEnabled:NO];
    [self.bigScroll setContentSize:CGSizeMake(320, 945)];
    [self.view addSubview:self.bigScroll];
    
    
    
    self.imaginiView.frame = CGRectMake(0, 0, 320, 360);//315
    self.imgScrollView.frame = CGRectMake(10, 12, 300,230);
    [self.imaginiView addSubview:self.imgScrollView];
    [self.bigScroll addSubview:self.imaginiView];
    

    
    self.detaliiView.frame = CGRectMake(0, 315, 320, 360);
    [self.bigScroll addSubview:self.detaliiView];

    self.contactView.frame = CGRectMake(0, 630, 320, 360);
    [self.bigScroll addSubview:self.contactView];

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    
}

-(UIImage*) imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    //pentru a pastra proportiile
    float hfactor = image.size.width/newSize.width;
    float vfactor = image.size.height/newSize.height;
    float factor = MAX(hfactor, vfactor);
    factor = MAX(factor, 1); //pt a nu redimesniona imagini care sunt deja <
    
    CGSize propotionalSize = CGSizeMake((image.size.width/factor), (image.size.height/factor));
    
    UIGraphicsBeginImageContext(propotionalSize);
    [image drawInRect:CGRectMake(0, 0, propotionalSize.width, propotionalSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
    [favButton release];
    [imgView release];
    [imgScrollView release];
    [imageViewsArray release];
    [imgList release]; 
    [bigScroll release];
    [adTextView release];
    [contactEmailLabel release];
    [callButton release];
    [headerView release];
    [imaginiView release];
    [detaliiView release];
    [contactView release];
    [propertySize release];
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
