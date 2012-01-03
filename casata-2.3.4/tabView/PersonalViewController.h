//
//  FifthViewController.h
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalViewController : UIViewController {
    UIViewController *activeViewController;
    UISegmentedControl *segmentedControl;
    NSArray *segmentedViewControllers;
}

@property (retain, nonatomic) UIViewController *activeViewController;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (retain, nonatomic) NSArray *segmentedViewControllers;


- (void)didChangeSegmentControl:(UISegmentedControl *)control;
- (void) goHome;

@end
