//
//  DetaliiAdaugaAnuntViewController.h
//  casata
//
//  Created by me on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetaliiAdaugaAnuntViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    UITableView  *tableImobil;
    NSMutableArray *propertyTypes;
}

@property (nonatomic, retain) IBOutlet UITableView *tableImobil;

@end
