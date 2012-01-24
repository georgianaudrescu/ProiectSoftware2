//
//  ThirdViewController.m
//  tabView
//
//  Created by Oana B on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StatsViewController.h"
#include "AppDelegate.h"
#import "CorePlot-CocoaTouch.h"
#import "Filtre.h"
#import "MyAdsViewController.h"

@implementation StatsViewController
@synthesize avgAreaPriceLabel, trendForAvgAreaPriceButton, filters;
@synthesize headerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Statistici", @"Statistici");
        self.tabBarItem.image = [UIImage imageNamed:@"linechart"];
        
        [self setTitle:@"Statistici"];
        
    }
    return self;
}


- (void)switchToFilter{
    /*
     [self.statisticsView addSubview:someView.view];
     //for animation
     //start from
     someView.view.frame = CGRectMake(320,0, self.statisticsView.frame.size.width, self.statisticsView.frame.size.height);
     //stop at
     [UIView animateWithDuration:0.5 animations:^{
     someView.view.frame = CGRectMake(0,0, self.statisticsView.frame.size.width, self.statisticsView.frame.size.height);}];
     */
    
    
    //Filtre * filters=[[Filtre alloc] initWithNibName:@"Filtre" bundle:nil];
    [self.view addSubview:filters.view];
    //[self.view setContentSize:CGSizeMake(320, 900)];
    filters.view.frame = CGRectMake(320,0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        filters.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);}];
    
    
}
-(void)switchToMyAds{
    //MyAdsViewController *myAds = [[MyAdsViewController alloc] initWithNibName:@"MyAdsViewController" bundle:nil];
    [self.view addSubview:myAds.view];
    //for animation
    myAds.view.frame = CGRectMake(-320,0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        myAds.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);}];
}





- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)clearChartStatistici
{

}
////////////////////
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return plotData.count;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSDecimalNumber *num = [[plotData objectAtIndex:index] objectForKey:[NSNumber numberWithInt:fieldEnum]];
    
    return num;
}

-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceUpEvent:(id)event atPoint:(CGPoint)point
{
    //CPTRangePlot *rangePlot = (CPTRangePlot *)[graph plotWithIdentifier:@"Date Plot"];
    
    //rangePlot.areaFill         = (rangePlot.areaFill ? nil : areaFill);
    //rangePlot.barLineStyle = (rangePlot.barLineStyle ? nil : barLineStyle);
    
    return NO;
}

-(void) createTheGraph
{
    // create an CPXYGraph and host it inside the view
    NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
    [comps setDay:29];
    [comps setMonth:10];
    [comps setYear:2009];
    [comps setHour:12];
    
    NSDate *refDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    // NSDate *refDate           = [NSDate dateWithNaturalLanguageString:@"12:00 Oct 29, 2009"];
    
    NSTimeInterval oneDay = 24 * 60 * 60;
    
    // Create graph from theme
    graph = [(CPTXYGraph *)[CPTXYGraph alloc] initWithFrame:CGRectZero];
    CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    [graph applyTheme:theme];
    hostView.hostedGraph = graph;
    
    // Title
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color                 = [CPTColor blackColor];
    textStyle.fontSize              = 18.0f;
    textStyle.fontName              = @"Helvetica";
    graph.title                             = @"";
    graph.titleTextStyle    = textStyle;
    graph.titleDisplacement = CGPointMake(0.0f, -20.0f);
    
    // Setup scatter plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    NSTimeInterval xLow               = oneDay * 0.5f;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xLow) length:CPTDecimalFromFloat(oneDay * 5.0f)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(1.0) length:CPTDecimalFromFloat(3.0)];
    
    // Axes
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x              = axisSet.xAxis;
    x.majorIntervalLength             = CPTDecimalFromFloat(oneDay);
    x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"2");
    x.minorTicksPerInterval           = 0;
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    dateFormatter.dateStyle = kCFDateFormatterShortStyle;
    CPTTimeFormatter *timeFormatter = [[[CPTTimeFormatter alloc] initWithDateFormatter:dateFormatter] autorelease];
    timeFormatter.referenceDate = refDate;
    x.labelFormatter                        = timeFormatter;
    
    CPTXYAxis *y = axisSet.yAxis;
    y.majorIntervalLength             = CPTDecimalFromString(@"0.5");
    y.minorTicksPerInterval           = 5;
    y.orthogonalCoordinateDecimal = CPTDecimalFromFloat(oneDay);
    
    // Create a plot that uses the data source method
    CPTRangePlot *dataSourceLinePlot = [[[CPTRangePlot alloc] init] autorelease];
    dataSourceLinePlot.identifier = @"Date Plot";
    
    // Add line style
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineWidth                             = 1.0f;
    lineStyle.lineColor                             = [CPTColor greenColor];
    barLineStyle                                    = [lineStyle retain];
    dataSourceLinePlot.barLineStyle = barLineStyle;
    
    // Bar properties
    dataSourceLinePlot.barWidth       = 1.0f;
    dataSourceLinePlot.gapWidth       = 2.0f;
    dataSourceLinePlot.gapHeight  = 2.0f;
    dataSourceLinePlot.dataSource = self;
    
    // Add plot
    [graph addPlot:dataSourceLinePlot];
    graph.defaultPlotSpace.delegate = self;
    
    // Store area fill for use later
    CPTColor *transparentGreen = [[CPTColor yellowColor] colorWithAlphaComponent:1.0];
    areaFill = [[CPTFill alloc] initWithColor:(id)transparentGreen];
    
    // Add some data
    NSMutableArray *newData = [NSMutableArray array];
    NSUInteger i;
    for ( i = 0; i < 5; i++ ) {
        NSTimeInterval x = oneDay * (i + 1.0);
        float y                  = 3.0f * rand() / (float)RAND_MAX + 1.2f;
        float rHigh              = rand() / (float)RAND_MAX * 0.05f + 0.025f;
        float rLow               = rand() / (float)RAND_MAX * 0.05f + 0.025f;
        float rLeft              = (rand() / (float)RAND_MAX * 0.0125f + 0.0125f) * oneDay;
        float rRight     = (rand() / (float)RAND_MAX * 0.0125f + 0.0125f) * oneDay;
        
        [newData addObject:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [NSDecimalNumber numberWithFloat:x], [NSNumber numberWithInt:CPTRangePlotFieldX],
          [NSDecimalNumber numberWithFloat:y], [NSNumber numberWithInt:CPTRangePlotFieldY],
          [NSDecimalNumber numberWithFloat:rHigh], [NSNumber numberWithInt:CPTRangePlotFieldHigh],
          [NSDecimalNumber numberWithFloat:rLow], [NSNumber numberWithInt:CPTRangePlotFieldLow],
          [NSDecimalNumber numberWithFloat:rLeft], [NSNumber numberWithInt:CPTRangePlotFieldLeft],
          [NSDecimalNumber numberWithFloat:rRight], [NSNumber numberWithInt:CPTRangePlotFieldRight],
          nil]];
    }
    plotData = newData; 
    //////////////////
    CPTRangePlot *rangePlot = (CPTRangePlot *)[graph plotWithIdentifier:@"Date Plot"];
    
    rangePlot.areaFill         = (rangePlot.areaFill ? nil : areaFill);
    rangePlot.barLineStyle = (rangePlot.barLineStyle ? nil : barLineStyle);
   /////////////// 
}
////////////////////
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    filters=[[Filtre alloc] initWithNibName:@"Filtre" bundle:nil];
    myAds = [[MyAdsViewController alloc] initWithNibName:@"MyAdsViewController" bundle:nil];
   
    [self createTheGraph];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(switchToFilter)];
    swipeLeft.numberOfTouchesRequired=1;
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.headerView addGestureRecognizer:swipeLeft];  
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(switchToMyAds)];
    swipeRight.numberOfTouchesRequired=1;
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.headerView addGestureRecognizer:swipeRight];
    
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *) self.navigationItem.titleView;
    if(!titleView)
    {titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont boldSystemFontOfSize:20];
        //titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        titleView.textColor = [UIColor blackColor];
        self.navigationItem.titleView = titleView;
        [titleView release];
    }
    titleView.text = title;
    [titleView sizeToFit];
    
    
}
-(void) dealloc
{
    [plotData release];
    [graph release];
    [areaFill release];
    [barLineStyle release];
    [avgAreaPriceLabel release];
    [trendForAvgAreaPriceButton release];
    [headerView release];
    [filters dealloc];
    [myAds dealloc];
    [super dealloc];

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
