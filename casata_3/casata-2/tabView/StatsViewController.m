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

@implementation StatsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Statistici", @"Statistici");
        self.tabBarItem.image = [UIImage imageNamed:@"linechart"];
        
        [self setTitle:@"Statistici"];
        
        
        
        
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(goHome)]autorelease];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"homepage.png"];
        
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearChartStatistici)]autorelease];   
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
       
        ///
        
        
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)goHome
{AppDelegate *apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [apdelegate goToHomeScreen];
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
    CPTRangePlot *rangePlot = (CPTRangePlot *)[graph plotWithIdentifier:@"Date Plot"];
    
    rangePlot.areaFill         = (rangePlot.areaFill ? nil : areaFill);
    rangePlot.barLineStyle = (rangePlot.barLineStyle ? nil : barLineStyle);
    
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
    graph.title                             = @"Click to Toggle Range Plot Style";
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
    dataSourceLinePlot.barWidth       = 10.0f;
    dataSourceLinePlot.gapWidth       = 20.0f;
    dataSourceLinePlot.gapHeight  = 20.0f;
    dataSourceLinePlot.dataSource = self;
    
    // Add plot
    [graph addPlot:dataSourceLinePlot];
    graph.defaultPlotSpace.delegate = self;
    
    // Store area fill for use later
    CPTColor *transparentGreen = [[CPTColor greenColor] colorWithAlphaComponent:0.2];
    areaFill = [[CPTFill alloc] initWithColor:(id)transparentGreen];
    
    // Add some data
    NSMutableArray *newData = [NSMutableArray array];
    NSUInteger i;
    for ( i = 0; i < 5; i++ ) {
        NSTimeInterval x = oneDay * (i + 1.0);
        float y                  = 3.0f * rand() / (float)RAND_MAX + 1.2f;
        float rHigh              = rand() / (float)RAND_MAX * 0.5f + 0.25f;
        float rLow               = rand() / (float)RAND_MAX * 0.5f + 0.25f;
        float rLeft              = (rand() / (float)RAND_MAX * 0.125f + 0.125f) * oneDay;
        float rRight     = (rand() / (float)RAND_MAX * 0.125f + 0.125f) * oneDay;
        
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
    
}
////////////////////
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self createTheGraph];
    
    
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
    [super dealloc];}


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
