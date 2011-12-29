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
    UIButton *buttonSearch, *buttonAnunturiApropiere, *buttonFav, *buttonSetari, *buttonStats, *buttonLogin, *buttonAbout, *buttonSavedSearch;
    
}
@property (nonatomic, retain) IBOutlet UIButton *buttonSearch,*buttonAnunturiApropiere, *buttonFav, *buttonSetari, *buttonStats, *buttonLogin, *buttonAbout, *buttonSavedSearch;
-(IBAction)selectPage:(UIButton*)aButton;

@end
