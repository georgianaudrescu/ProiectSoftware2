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
    UIButton *buttonAnunturiApropiere, *buttonStats, *buttonAbout, *buttonAdaugaAnunt;
    
}
@property (nonatomic, retain) IBOutlet UIButton *buttonAnunturiApropiere, *buttonStats,*buttonAbout, *buttonAdaugaAnunt;
-(IBAction)selectPage:(UIButton*)aButton;

@end
