//
//  FiltreTableViewController.h
//  casata
//
//  Created by me on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiltreTableViewController : UITableViewController
{
    NSDictionary *tableContents;
    NSArray *sortedKeys;

    
}
@property(nonatomic,retain)NSDictionary *tableContents;
@property(nonatomic,retain)NSArray *sortedKeys;

-(void)aplicaFiltre;
@end
