//
//  ThirdViewController.h
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface StatsViewController : UIViewController<CPTPlotDataSource, CPTPlotSpaceDelegate>
{
    IBOutlet CPTGraphHostingView *hostView;
    CPTXYGraph *graph;
    NSArray *plotData;
    CPTFill *areaFill;
    CPTLineStyle *barLineStyle;
    
    ///pt header-la labels- schimbam doar textul, la butoane- in functie de valoarea negativa/pozitiva schimbam si imaginea:
    UILabel *pretMediuVanzareLabel, *pretMediuInchiriereLabel;
    UIButton *trendPretVanzareButton, *trendPretInchiriereButton;
}
@property (nonatomic,retain) IBOutlet UILabel *pretMediuVanzareLabel, *pretMediuInchiriereLabel;
@property(nonatomic,retain) IBOutlet UIButton *trendPretVanzareButton, *trendPretInchiriereButton;


-(void)clearChartStatistici;
-(void) createTheGraph;
@end
