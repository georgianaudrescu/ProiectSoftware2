//
//  SyncTableViewController.h
//  casata
//
//  Created by Oana B on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SyncTableViewController : UITableViewController
{
    NSDictionary *tableContents;
    NSArray *sortedKeys;
    
    
}
@property(nonatomic,retain)NSDictionary *tableContents;
@property(nonatomic,retain)NSArray *sortedKeys;

-(void)doneButton;

@end
