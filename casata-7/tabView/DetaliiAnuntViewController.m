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
@synthesize pretLabel, propertyTypeLabel, monedaLabel, contactNameLabel, contactPhoneLabel, adTextLabel, adressLineLabel,nameLabel, anuntTypeLabel, favButton;
@synthesize thumbnailImageView;
@synthesize imgView, imgScrollView,imageViewsArray, imgList;
@synthesize delegate, hidePinIfRemovedFromFav; //pt a seta map ca delegate
//@synthesize popView, popViewContact; 
@synthesize bigScroll, adTextView;

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

-(void)loadAdWithId:(int)theAdId
{
    //[self.imageViewsArray release];
    //self.imageViewsArray = [[NSMutableArray alloc]init];
    
    self.theAd = [apdelegate.appSession.globalAdList getAdWithId:theAdId];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.bigScroll setContentOffset:CGPointMake(0, 0)];
    
    
    NSLog(@"Judetul ad-ului selectat:%@", [self.theAd.ad objectForKey:@"judet"]);
    
    //punerea textului anuntului in label-urile corespunzatoare
    self.nameLabel.text = [self.theAd.ad objectForKey:@"name"];
    self.propertyTypeLabel.text =[self.theAd.ad objectForKey:@"property_type"];
    //self.adTextLabel.text = [NSString stringWithFormat:@"Descriere:  %@", [self.theAd.ad objectForKey:@"ad_text"]];
    self.adressLineLabel.text = [self.theAd.ad objectForKey:@"adress_line"];
    //---NSNumber *pret = [self.theAd.ad objectForKey:@"pret"];
    
    self.pretLabel.text = [NSString stringWithFormat:@"%d %@",[[self.theAd.ad objectForKey:@"pret"] intValue], [self.theAd.ad objectForKey:@"moneda"]];
   
    self.contactNameLabel.text = [self.theAd.ad objectForKey:@"contact_name"];
    self.contactPhoneLabel.text = [self.theAd.ad objectForKey:@"contact_phone"];
    self.anuntTypeLabel.text = [self.theAd.ad objectForKey:@"ad_type"];
    
    self.thumbnailImageView.image = [UIImage imageNamed:@"house2.jpg"];
    
    
    /*
    //ajustarea dimensiunii textului/label-ului
    NSLog(@"nr charactere adresa: %d", [[self.theAd.ad objectForKey:@"adress_line"] length]);
   
    
    if([[self.theAd.ad objectForKey:@"adress_line"] length] <=24)
    {[self.adressLineLabel sizeToFit];
       // self.adressLineLabel.frame = CGRectMake(20, 346, 281, self.adressLineLabel.frame.size.height);
       
    }
    else
    {[self.adressLineLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [self.adressLineLabel sizeToFit];
    }
    
   
    if([[self.theAd.ad objectForKey:@"ad_text"] length] <=24)
    {[self.adTextLabel sizeToFit];
     
        //self.adTextLabel.frame = CGRectMake(20, 298, 280, self.adTextLabel.frame.size.height);
    }
     else 
     {[self.adTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [self.adTextLabel sizeToFit];
     }
     */
    
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
    
    
    int nr=4;
    
    for(int x=0;x<nr;x++)
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
        TImage *theImag =  [self.imgList getImageAtIndex:x];
        UIImage *butImage = theImag.image;
        if(x==0)self.imgView.image = theImag.image;
        theImag=nil;
        //
        imageView.image = butImage;
        [butImage release];
        
        [self.imageViewsArray addObject:imageView];
        [self.imgScrollView addSubview:[self.imageViewsArray objectAtIndex:x]];
        
        
    }       
    
    
     self.imgScrollView.contentSize = CGSizeMake(nr*300, 230);
    [self.imgScrollView setPagingEnabled:YES];
    [self.imgScrollView setBounces:NO];
    
    
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.imgScrollView.frame = CGRectMake(10, 180, 300, 200);    
    
    self.bigScroll.frame = CGRectMake(0, 100, 320, 360);
    [self.bigScroll setPagingEnabled:YES];
    [self.bigScroll setContentSize:CGSizeMake(320, 945)];
    [self.view addSubview:self.bigScroll];
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
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
