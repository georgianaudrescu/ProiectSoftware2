//
//  AdaugAnuntViewController.h
//  casata
//
//  Created by me on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdaugAnuntViewController : UIViewController
{
    UISegmentedControl *segmentedControl;
    UIViewController      * activeViewController;
    NSArray               * segmentedViewControllers;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl * segmentedControl;
@property (nonatomic, retain) UIViewController            * activeViewController;
@property (nonatomic, retain) NSArray                     * segmentedViewControllers;

- (void)didChangeSegmentControl:(UISegmentedControl *)control;

-(void)goHome;

@end
