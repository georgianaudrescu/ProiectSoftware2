//
//  ViewController.h
//  PrimaPagina
//
//  Created by me on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    UIButton *buttonAbout, *buttonAplicatie;
    
}
@property (nonatomic, retain) IBOutlet UIButton *buttonAbout,*buttonAplicatie;

-(IBAction)selectPage:(UIButton*)aButton;

@end
