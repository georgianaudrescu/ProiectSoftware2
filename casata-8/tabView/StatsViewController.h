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

@interface StatsViewController : UIViewController<CPTPlotDataSource, CPTPlotSpaceDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet CPTGraphHostingView *hostView;
    CPTXYGraph *graph;
    NSMutableArray *plotDataFaraFiltre;
    NSMutableArray *plotDataCuFiltre;
    CPTFill *areaFill;
    CPTLineStyle *barLineStyle;
    
    ///pt header-la labels- schimbam doar textul, la butoane- in functie de valoarea negativa/pozitiva schimbam si imaginea:
    UILabel *avgAreaPriceLabel;
    UIButton *trendForAvgAreaPriceButton;
    UILabel *generalAvgPriceLabel;
    UILabel *filterAvgPriceLabel;
    UIButton *generalTrendButton;
    UIButton *filterTrendButton;
    Filtre * filters;
    MyAdsViewController *myAds;
    UIView *headerView;
    AppDelegate *apdelegate;
    UIView * filtreView;
    UILabel *filtreLabel;
    int min, max;
}
@property (nonatomic,retain) IBOutlet UILabel *avgAreaPriceLabel,*generalAvgPriceLabel,*filterAvgPriceLabel,*filtreLabel;
@property(nonatomic,retain) IBOutlet UIButton *trendForAvgAreaPriceButton,*generalTrendButton,*filterTrendButton;
@property (nonatomic, retain) Filtre *filters;
@property(nonatomic, retain) MyAdsViewController *myAds;
@property(nonatomic,retain) IBOutlet UIView *headerView, *filtreView;
@property (nonatomic, retain, readwrite) NSMutableArray *plotDataFaraFiltre,*plotDataCuFiltre;

-(void)clearChartStatistici;
-(void) createTheGraph:(BOOL)filtreleSuntActive;
-(void)switchToFilter;
-(void)switchToMyAds;
-(void)refreshStats;
-(void)loadPlotData:(BOOL)filtreleSuntActive;

@end
