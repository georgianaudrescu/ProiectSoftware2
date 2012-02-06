//
//  AdaugaImaginiViewController.m
//  casata
//
//  Created by me on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AdaugaImaginiViewController.h"
#import "TImage.h" //just for test
//#import "TFav.h"//just for test
#import "AppDelegate.h"//just for test
#import "TImage.h"
#import "TImageList.h"
#import "TStatistic.h"
#include <math.h>


@implementation AdaugaImaginiViewController
@synthesize imgScrollView, imageViewsArray, generalScrollView;
@synthesize currentImageNr, totalImages, defaultImageIndex;
@synthesize toolBar, disabledView, defaultView;
@synthesize picker;
@synthesize tempAd;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Adauga Imagini"];
        
        //setam butonul din dreapta navBar-ului -adauga imaginile la anunt
        self.navigationItem.rightBarButtonItem =  [[[UIBarButtonItem alloc] initWithTitle:@"Default" style:UIBarButtonItemStylePlain target:self action:@selector(setCurrentImageAsDefault)]autorelease]; 
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];

    }
    return self;
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
    // Do any additional setup after loading the view from its nib.

    
    
    
    
    
    
    
    
//TESTS   
   /******* TStatistics Test*

    NSString *aString = @"avg_price: [{ pos:29,price: 2313,date: 2012-01-06},{pos: 30,price: 2050.4,date: 2012-01-07}],avg_total: 2050,request: get_stats,status: OK}";
    TStatistic *aStat = [[TStatistic alloc]init];
    NSData * data=[aString dataUsingEncoding: [NSString defaultCStringEncoding] ];
    if ([data length]!=0) {
        [aStat parseDataRecieved:data];
        NSString *aaa= [[NSString alloc] initWithFormat:@"%f", aStat.avgTotal];
        NSLog(@"total average %a",aaa);
    }
    else NSLog(@"data is null!!");
    
    [aString release];
    [aStat release];
    [data release];
  */ 

    
  /* *******TLocationList Test********
   //
   TLocationList * myList = [[TLocationList alloc] init];
   CLLocationCoordinate2D testCoor;
   testCoor.latitude = 26.66;
   testCoor.longitude = 44.333;
   TLocation * testLoc = [[TLocation alloc] initWithTitle:@"nume" andSubtitle:@"subtitle" andCoord:testCoor];
   NSLog(@"name1 %@",testLoc.title);
   [myList addLocation:testLoc];
   TLocation * newLoc = [myList getLocationFromIndex:0];
   NSString * aString = newLoc.title;
   NSLog(@"name %@", aString);
   NSLog(@"index %d",[myList getIndexForLocation:testLoc] );
   NSLog(@"count:%d", myList.count);
   [myList removeLocation:testLoc];
   NSLog(@"count:%d", myList.count);
   
   [myList release];
   [newLoc release];
   //end Location Test***** */
  
    
    
    /*  
   // ********TImage test  
    TImage *anImage = [TImage alloc];
    anImage.imageId=1;
    anImage.description=@"etc";
   
   //initializare cu ajutorul unui url
    [anImage initWithImageFromUrlString:@"http://www.incasa.ro/_files/Image/galerie/5/casa_1.jpg"];
   
   //initializarea imageView-ului cu un UIImage(folositor pt image upload, unde pickerul returneaza un UIImage)
   //[anImage initWithImage:[UIImage imageNamed:@"house.jpg"]]; 
    //anImage.imageView.frame = CGRectMake(0, 0, 30, 30);
    [self.view addSubview:anImage.imageView];
     TImageList *imgList = [[TImageList alloc]init];
    
    [imgList addImage:anImage];
    
    
    TImage *test = [imgList getImageAtIndex:0];
    
    NSLog(@"desc of imag %@", test.description);
    
    NSLog(@"index:%d", [imgList getIndexForImage:anImage]);
    NSLog(@"count:%d", imgList.count);
    [imgList removeImage:anImage];
    NSLog(@"count:%d", imgList.count);
   
     
    [anImage release];
    [imgList release];
    
    */
    
    
   /*
  // *****globalvariablestest
     AppDelegate *apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *aString = [[NSString alloc] initWithString:@"AAAaaaaaaaaSTRING"];
    [apdelegate.appSession.globalAdList addObject:aString];
    [aString release];
    NSLog(@"%@",[apdelegate.appSession.globalAdList objectAtIndex:0]);
    NSString *lati = [[NSString alloc]initWithString:@"44.44"];
    NSString *longi = [[NSString alloc]initWithString:@"22.22"];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = lati.doubleValue;
    coordinate.longitude = longi.doubleValue; 
    apdelegate.appSession.currentLocation.coordinate=coordinate;
    [lati release];
    [longi release];
    
    NSString *aaa = [[NSString alloc] initWithFormat:@"%f",  apdelegate.appSession.currentLocation.coordinate];
    NSLog(@"coord:%@",aaa);
    [aaa release];
    */
    
    /* 
     // *TFav Location test
    AppDelegate *apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    TLocation *loc = [TLocation alloc];
    NSString *lati = [[NSString alloc]initWithString:@"44.44"];
    NSString *longi = [[NSString alloc]initWithString:@"22.22"];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = lati.doubleValue;
    coordinate.longitude = longi.doubleValue; 
    
    [loc initWithTitle:@"a" andSubtitle:@"b" andCoord:coordinate];
    
    [lati release];
    [longi release];
    
    [apdelegate.appSession.favorites addLocation:loc];
    [loc release];
    TLocation *aloca = [TLocation alloc];
    aloca=[apdelegate.appSession.favorites getLocationAtIndex:0];
   
    NSString *aaa = [[NSString alloc] initWithFormat:@"%f", aloca.coordinate.longitude];
    NSLog(@"coord:%@",aaa);
    [aaa release];

*/
    
 /*   
 //TAdlist tests
   TRequest * myRequest = [TRequest alloc] ;
    [myRequest initWithHost:@"http://flapptest.comule.com"];
    NSString *postString = @"left=25%2E96&sessionTime=1325693857685&right=26%2E24&bottom=44%2E33&top=44%2E53&currency=euro&request=get%5Fads&zoom=5000&sid=session1";
    
    if([myRequest makeRequestWithString:postString]!=0) 
    { TAdList *aAdList = [[TAdList alloc]init];
        [aAdList populateListWithRequest:myRequest];
        [myRequest release];
        NSLog(@"adlist count:%d", aAdList.adList.count);
        
        
       TAd *anAd = [TAd alloc];
        anAd = [aAdList getAdAtIndex:0];
        NSLog (@"first ad id ->%@",[anAd.ad objectForKey:@"name"]);
            
        anAd=nil;
        
        TAd *annAd = [TAd alloc];
        annAd = [aAdList getAdAtIndex:0];
        NSLog (@"second ad id ->%@",[annAd.ad objectForKey:@"name"]);
        NSLog(@"adlist count:%d", aAdList.adList.count);
        
        anAd=nil;       
        [aAdList release];
      
    }
   */
    
    //self.theImageList = [[TImageList alloc] init];
    self.defaultView.frame = CGRectMake(10, 0, 300, 372);
    
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate=self;
    //self.picker.navigationBar.tintColor = [UIColor colorWithRed:0.976 green:0.827 blue:0.015 alpha:1.0]; 
    self.picker.navigationBar.barStyle = UIBarStyleBlack;
    self.imageViewsArray = [[NSMutableArray alloc]init];
    self.currentImageNr =0 ;  
    self.totalImages=0;
    self.defaultImageIndex=-1;   
    //self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imgScrollView setPagingEnabled:YES];
    self.imgScrollView.delegate = self;
   [self.generalScrollView setContentSize:CGSizeMake(320, 750)];
    
    
    //daca nu avem inca nici o imagine in lista, dam disable la butonul de sters, texfield-ul si butonul de default
    if(tempAd.imageList.count==0)
    {[[self.toolBar.items objectAtIndex:2] setEnabled:NO];
        [[self.toolBar.items objectAtIndex:3] setEnabled:NO];
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        [self.generalScrollView addSubview:self.defaultView];   
    }
    else //daca avem , afisam imaginile existente
    {[self showAlreadyExistentImages];}    
    

}


-(IBAction)preiaImagineCuCamera:(id)sender
{
   if(self.totalImages ==10)
   {
       UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Nu mai poti adauga imagini" message:@"Ai deja numarul maxim de 10 imagini care pot fi adaugate unui anunt!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] autorelease];
       [alertView show];
   }
    else
    {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:picker animated:YES];
    }
}

-(IBAction)preiaImagineDinGalerie:(id)sender
{
    if(self.totalImages ==10)
    {
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Nu mai poti adauga imagini" message:@"Ai deja numarul maxim de 10 imagini care pot fi adaugate unui anunt!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] autorelease];
        [alertView show];
    }
    else
    {
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:picker animated:YES];
    }

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //self.imgView.image = image;
    if(self.totalImages==0)
    { //cand se adauga prima imagine, se fac enabled butonul de sterge, texfield-ul si butonul de default
        [[self.toolBar.items objectAtIndex:2] setEnabled:YES];
        [[self.toolBar.items objectAtIndex:3] setEnabled:YES];
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
        [self.defaultView removeFromSuperview]; 
    }
    
    UIImageView *imageView = [[[UIImageView alloc] init]autorelease];
    //----imageView.image = image;
    NSLog(@"rezolutie iamgine inainte: %fx%f",image.size.width, image.size.height);
    imageView.image = [self imageWithImage:image scaledToSize:CGSizeMake(300, 300)];//++++
    
    
    NSLog(@"rezolutie iamgine dupa: %fx%f",imageView.image.size.width, imageView.image.size.height);
    
    
    [imageView setFrame:CGRectMake((self.totalImages*300), 0, 300, 300)];
    
    //----imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.contentMode = UIViewContentModeCenter;//+++++
       
    [self.imageViewsArray addObject:imageView]; 
    
    TImage *img1 = [TImage alloc];
    [img1 initWithImage:[self imageWithImage:image scaledToSize:CGSizeMake(300, 300)]];
    img1.defaultValue=0;
    //img1.description=@"";
    img1.name=@"";
    [tempAd.imageList addImage:img1];
    img1=nil;//

    
    //self.titluImagineTextField.text=@"";
   
    self.currentImageNr=self.totalImages;
    
    
   [self.imgScrollView addSubview:[self.imageViewsArray objectAtIndex:self.totalImages]];
    self.totalImages++;  
    [self.imgScrollView setContentSize:CGSizeMake((self.totalImages*300), 300)];
    
    //muta automat scrollul cand adaugam
    if(self.totalImages>1)[self.imgScrollView setContentOffset: CGPointMake((self.totalImages-1)*300, 0) animated:YES];  
     
    [self dismissModalViewControllerAnimated:YES];
}


//stergerea unei imagini - tratarea tuturor cazurilor, inlocuirea tag-urilor pt butoanele ramase dupa stergere


-(IBAction)stergeImagineCurenta:(id)sender
{ 
    
    if(self.totalImages>0)
{
    
    
    if(self.totalImages==1)  //daca stergem singura imagine
    {
        self.currentImageNr=0;
        
        //self.imgView.image = [UIImage imageNamed:@"emptyImage.png"];
        //self.titluImagineTextField.text=@"";
        self.defaultImageIndex=-1;
        //self.descriereImagineTextField.text=@"";
        
        
        [[self.imageViewsArray objectAtIndex:self.currentImageNr] removeFromSuperview];
        
        [self.imageViewsArray removeObjectAtIndex:self.currentImageNr];
       [tempAd.imageList removeImageAtIndex:self.currentImageNr];
        self.totalImages--;
        self.currentImageNr=0;        
        NSLog(@"just one image");
        
        [[self.toolBar.items objectAtIndex:2] setEnabled:NO];
        [[self.toolBar.items objectAtIndex:3] setEnabled:NO];
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        [self.generalScrollView addSubview:self.defaultView]; 
        
     }
    else
    {
        CGFloat a = self.imgScrollView.contentOffset.x;
        int b = (unsigned int) a;
        self.currentImageNr = b/300;
        
        //daca imaginea era imagine default, resetam indexul
        if(self.currentImageNr==self.defaultImageIndex)
        {self.defaultImageIndex=-1;
         [self.navigationItem.rightBarButtonItem setEnabled:YES];
        }
        
        if(self.currentImageNr==(self.totalImages-1))  //stergerea ultimei imag
        {
                        
            TImage *theImag =  [tempAd.imageList getImageAtIndex:(self.currentImageNr-1)];
           
            //self.titluImagineTextField.text=theImag.name;
            //self.descriereImagineTextField.text=theImag.description;
           
            theImag=nil;
           
            [[self.imageViewsArray objectAtIndex:self.currentImageNr] removeFromSuperview];
            [self.imageViewsArray removeObjectAtIndex:self.currentImageNr];
            [tempAd.imageList removeImageAtIndex:self.currentImageNr];
            self.totalImages--;
            self.currentImageNr--;
            
            //daca cea care devine imag curenta dupa stergere e imag default=>disable but de default
            if(self.currentImageNr==self.defaultImageIndex)
            {[self.navigationItem.rightBarButtonItem setEnabled:NO];}
            
            
            [self.imgScrollView setContentSize:CGSizeMake((self.totalImages*300), 300)];
            
            
            
            NSLog(@"last image");
        }
    
        else
        {
       //stergerea unei imag care mai are imag dupa ea
   
    TImage *theImag =  [tempAd.imageList getImageAtIndex:(self.currentImageNr+1)];
           
            //self.titluImagineTextField.text=theImag.name;
            //self.descriereImagineTextField.text=theImag.description;
            
    theImag=nil;
    [[self.imageViewsArray objectAtIndex:self.currentImageNr] removeFromSuperview];
    [self.imageViewsArray removeObjectAtIndex:self.currentImageNr];
    [tempAd.imageList removeImageAtIndex:self.currentImageNr];
    self.totalImages--;  
            
  //daca cea stearsa nu era default, ci una de dupa cea stearsa
   if(self.defaultImageIndex!=-1&&self.defaultImageIndex>=self.currentImageNr)     {self.defaultImageIndex--;}
            //daca cea care devine imag curenta dupa stergere e imag default=>disable but de default
            if(self.currentImageNr==self.defaultImageIndex)
            {[self.navigationItem.rightBarButtonItem setEnabled:NO];}
        
            
    int x;
    for(x=self.currentImageNr;x<self.totalImages;x++)
    {[[self.imageViewsArray objectAtIndex:x] setFrame:CGRectMake((x*300), 0, 300, 300)];
        
    }
    
            [self.imgScrollView setContentSize:CGSizeMake((self.totalImages*300), 300)];
            
             
            
        }
    }
}   
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

   
    CGFloat a = self.imgScrollView.contentOffset.x;
    int b = (unsigned int) a;
    self.currentImageNr = b/300;
    
    TImage *theImag =  [tempAd.imageList getImageAtIndex:self.currentImageNr];
    //self.titluImagineTextField.text=theImag.name;
    theImag=nil;
    
    if(self.currentImageNr==self.defaultImageIndex)
    {[self.navigationItem.rightBarButtonItem setEnabled:NO];
    }
    else
    {[self.navigationItem.rightBarButtonItem setEnabled:YES];
    }

}


-(IBAction)enterEditingModeForTextField:(id)sender
{
   
    [[self.toolBar.items objectAtIndex:0] setEnabled:NO];
    [[self.toolBar.items objectAtIndex:1] setEnabled:NO];
    [[self.toolBar.items objectAtIndex:3] setEnabled:NO];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    NSLog(@"editing did begin");
    [self.generalScrollView addSubview:self.disabledView];
   [self.generalScrollView setContentOffset:CGPointMake(0, 216) animated:YES];
    
}
/*
-(IBAction) textFieldReturn:(id)sender{
    [[self.toolBar.items objectAtIndex:0] setEnabled:YES];
    [[self.toolBar.items objectAtIndex:1] setEnabled:YES];
    [[self.toolBar.items objectAtIndex:3] setEnabled:YES];
    
    
    if(self.currentImageNr!=self.defaultImageIndex)
    {[self.navigationItem.rightBarButtonItem setEnabled:YES];}
    
    if(self.totalImages>0)
        
    {  CGFloat a = self.imgScrollView.contentOffset.x;
        int b = (unsigned int) a;
        self.currentImageNr = b/300;
        
        TImage *theImag =  [tempAd.imageList getImageAtIndex:self.currentImageNr];
        //theImag.description = self.descriereImagineTextField.text;
        //theImag.name = self.titluImagineTextField.text;
        theImag=nil;
    }
    [self.disabledView removeFromSuperview]; 
     [self.generalScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [sender resignFirstResponder];
}


-(IBAction)backgroundTouched:(id)sender{
    if(self.totalImages>0)
    {  
        CGFloat a = self.imgScrollView.contentOffset.x;
        int b = (unsigned int) a;
        self.currentImageNr = b/300;        
        
        TImage *theImag =  [tempAd.imageList getImageAtIndex:self.currentImageNr];
       // theImag.description = self.descriereImagineTextField.text;
        //theImag.name = self.titluImagineTextField.text;
        theImag=nil;
    }
    
    //[self.titluImagineTextField resignFirstResponder];
    //[self.descriereImagineTextField resignFirstResponder];
}
*/

-(void)setCurrentImageAsDefault
{if(self.totalImages>0)
    
{  CGFloat a = self.imgScrollView.contentOffset.x;
    int b = (unsigned int) a;
    self.currentImageNr = b/300;
   
    if(self.defaultImageIndex!=-1)
    {TImage *theImag =  [tempAd.imageList getImageAtIndex:self.defaultImageIndex];
    theImag.defaultValue=0;
    theImag=nil;
        //NSLog(@"imag de la index: %d nu mai e default", self.defaultImageIndex);
    }
    
    TImage *theImag =  [tempAd.imageList getImageAtIndex:self.currentImageNr];
    theImag.defaultValue=1;
    theImag=nil;
    self.defaultImageIndex=self.currentImageNr;
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    //NSLog(@"acum imag de la indexul: %d e default", self.defaultImageIndex);
}    
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

-(void)showAlreadyExistentImages
{
    for(int x=0;x<tempAd.imageList.count;x++)
    {
        UIImageView *imageView = [[[UIImageView alloc] init]autorelease];
        TImage *img1 = [tempAd.imageList getImageAtIndex:x];
        imageView.image = img1.image;
        
        if(img1.defaultValue==1) {self.defaultImageIndex=x;
            [self.navigationItem.rightBarButtonItem setEnabled:NO];}
        else{[self.navigationItem.rightBarButtonItem setEnabled:YES];}
        
                           
        [imageView setFrame:CGRectMake((self.totalImages*300), 0, 300, 300)];
        
        //imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.contentMode = UIViewContentModeCenter;
        
        [self.imageViewsArray addObject:imageView]; 
        
       
        
        
        //self.titluImagineTextField.text=img1.name;
        
        self.currentImageNr=self.totalImages;
        
        
        [self.imgScrollView addSubview:[self.imageViewsArray objectAtIndex:self.totalImages]];
        self.totalImages++;  
        [self.imgScrollView setContentSize:CGSizeMake((self.totalImages*300), 300)];
        
        //muta automat scrollul cand adaugam - va ramane ultima imag vizibila, putem schimba sa ramana prima imag din lista vizibila(cand ereau deja imagini in lista)
        if(self.totalImages>1)[self.imgScrollView setContentOffset: CGPointMake((self.totalImages-1)*300, 0) animated:NO];  
    
        
        img1=nil;
    
    
    }
    
    
    
}


-(void) dealloc
{
    [tempAd release];
    //self.theImageList=nil;
    
    [imgScrollView release];
    [toolBar release];
    [generalScrollView release];
    [imageViewsArray release];
    [picker release];
    //[titluImagineTextField release];
    [disabledView release];
    [defaultView release];
    //[descriereImagineTextField release];
    [super  dealloc];

}

@end