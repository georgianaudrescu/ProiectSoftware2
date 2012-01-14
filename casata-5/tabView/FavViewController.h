//
//  FavViewController.h
//  casata
//
//  Created by me on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavViewController : UIViewController
{
    UILabel *favoritAles;
    UISegmentedControl *segmentedControl;
}
@property (nonatomic, retain) IBOutlet UILabel *favoritAles;
@property(nonatomic, retain) UISegmentedControl *segmentedControl;

-(void)goHome;
-(void)checkForSelectedFavFromHomePage;

@end
