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
@synthesize ad_id;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
    }
    return self;
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
 /*  TAd *aax = [TAd alloc];
    
    aax =[apdelegate.appSession.globalAdList getAdWithId:ad_id];
    NSLog(@"Judetul ad-ului selectat:%@", [aax.ad objectForKey:@"judet"]);
    [aax release];    
 */   
    
    NSLog(@"Ad_id----->%d",ad_id);
    NSLog(@"total ads: %d",apdelegate.appSession.globalAdList.count);
    
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
