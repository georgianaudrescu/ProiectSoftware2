//
//  MyAdsViewController.h
//  casata
//
//  Created by Oana B on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAdsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    UITableView *tableAds;
    
}

@property (nonatomic, retain) IBOutlet UITableView *tableAds;


-(IBAction)backToStatistics:(id)sender ;

@end
