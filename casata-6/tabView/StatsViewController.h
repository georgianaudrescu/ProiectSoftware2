//
//  ThirdViewController.h
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "Filtre.h"
#import "MyAdsViewController.h"

@interface StatsViewController : UIViewController<CPTPlotDataSource, CPTPlotSpaceDelegate>
{
    IBOutlet CPTGraphHostingView *hostView;
    CPTXYGraph *graph;
    NSArray *plotData;
    CPTFill *areaFill;
    CPTLineStyle *barLineStyle;
    
    ///pt header-la labels- schimbam doar textul, la butoane- in functie de valoarea negativa/pozitiva schimbam si imaginea:
    UILabel *avgAreaPriceLabel;
    UIButton *trendForAvgAreaPriceButton;
    Filtre * filters;
    MyAdsViewController *myAds;
}
@property (nonatomic,retain) IBOutlet UILabel *avgAreaPriceLabel;
@property(nonatomic,retain) IBOutlet UIButton *trendForAvgAreaPriceButton;
@property (nonatomic, retain) Filtre *filters;


-(void)clearChartStatistici;
-(void) createTheGraph;
@end
