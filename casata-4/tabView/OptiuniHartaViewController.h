//
//  OptiuniHartaViewController.h
//  casata
//
//  Created by me on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptiuniHartaViewController : UIViewController
{UISegmentedControl *segmentedControl;
    UIViewController      * activeViewController;
    NSArray               * segmentedViewControllers;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl * segmentedControl;
@property (nonatomic, retain) UIViewController            * activeViewController;
@property (nonatomic, retain) NSArray                     * segmentedViewControllers;

- (void)didChangeSegmentControl:(UISegmentedControl *)control;

@end
