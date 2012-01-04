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
}
-(void)goHome;
-(void)clearChartStatistici;
-(void) createTheGraph;
@end
