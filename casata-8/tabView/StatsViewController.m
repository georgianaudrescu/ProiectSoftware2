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
@synthesize avgAreaPriceLabel, trendForAvgAreaPriceButton, filters, myAds;
@synthesize headerView, filtreView;
@synthesize generalTrendButton, filterTrendButton, generalAvgPriceLabel, filterAvgPriceLabel, filtreLabel;
@synthesize plotDataCuFiltre, plotDataFaraFiltre;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Statistici", @"Statistici");
        self.tabBarItem.image = [UIImage imageNamed:@"linechart"];
        
        [self setTitle:@"Statistici"];
        
        apdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
    }
    return self;
}


- (void)switchToFilter{
    
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
    if ([plot.identifier isEqual:@"faraFiltre"])
    {  
    return [apdelegate.appSession.stats.generalAvg count];
    }
    else
    {return [apdelegate.appSession.stats.filterAvg count];}
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot 
                     field:(NSUInteger)fieldEnum 
               recordIndex:(NSUInteger)index 
{
    switch (fieldEnum)
    {
        case CPTScatterPlotFieldX: 
        {
            int x=0;
            if ([plot.identifier isEqual:@"faraFiltre"])
            {  
            // inverse numbers, so first (latest) test run is on the right.
             x = 31*(24*60*60)-[[[apdelegate.appSession.stats.generalAvg objectAtIndex:index] objectForKey:@"pos"]intValue]*(24*60*60); 
            }
            else{x = 31*(24*60*60)-[[[apdelegate.appSession.stats.filterAvg objectAtIndex:index] objectForKey:@"pos"]intValue]*(24*60*60);
            }
            
            return [NSDecimalNumber numberWithInt:x];
        }
        case CPTScatterPlotFieldY:
        {
            if ([plot.identifier isEqual:@"faraFiltre"])
            {
                NSLog(@"index when constructing plot:%d",index);
               // NSLog(@"data when constructing plot: %@",[self.plotDataFaraFiltre objectAtIndex:index]);
               // float v = [[self.plotDataFaraFiltre objectAtIndex:index] intValue];
                
                float v = [[[apdelegate.appSession.stats.generalAvg objectAtIndex:index] objectForKey:@"price"]intValue];
                return [NSNumber numberWithFloat:v];
            }
            else
            {
                float v = [[plotDataCuFiltre objectAtIndex:index] intValue];
                return [NSNumber numberWithFloat:v];
            }
        }
    }
    return nil;
}


-(void) createTheGraph:(BOOL)filtreleSuntActive
{
    // create an CPXYGraph and host it inside the view
    NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
    [comps setDay:29];
    [comps setMonth:10];
    [comps setYear:2009];
    [comps setHour:12];
    
    // NSDate *refDate = [NSDate date];
    NSDate *refDate = [NSDate dateWithTimeIntervalSinceNow:-86400*31];
    //NSDate *refDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    // NSDate *refDate           = [NSDate dateWithNaturalLanguageString:@"12:00 Oct 29, 2009"];
    
    NSTimeInterval oneDay = 24 * 60 * 60;
    
    // Create graph from theme
    graph = [(CPTXYGraph *)[CPTXYGraph alloc] initWithFrame:CGRectZero];
    //CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
    [graph applyTheme:theme];
    hostView.hostedGraph = graph;
    
    
        
    // Setup scatter plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    NSTimeInterval xLow               = -oneDay*5 ;//era 0.5
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xLow) length:CPTDecimalFromFloat(oneDay * 38.0f)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(min -((max-min)/10)) length:CPTDecimalFromFloat(max-min)];
    
    
    graph.paddingLeft = 0.0;
    graph.paddingTop = 0.0;
    graph.paddingRight = 0.0;
    graph.paddingBottom = 0.0;
    
    NSString *start = [NSString stringWithFormat:@"%d", min];    
    
    // Axes
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x              = axisSet.xAxis;
    x.majorIntervalLength             = CPTDecimalFromFloat(5*oneDay);
    x.orthogonalCoordinateDecimal = CPTDecimalFromString(start); //era 2
    x.minorTicksPerInterval           = 0;
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    dateFormatter.dateStyle = kCFDateFormatterShortStyle;
    [dateFormatter setDateFormat:@"dd/MM"];
    CPTTimeFormatter *timeFormatter = [[[CPTTimeFormatter alloc] initWithDateFormatter:dateFormatter] autorelease];
    timeFormatter.referenceDate = refDate;
    x.labelFormatter                        = timeFormatter;
    x.labelExclusionRanges = [NSArray arrayWithObjects:
                              [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-oneDay*5) length:CPTDecimalFromFloat(oneDay*5)], nil];
    
    
    NSString *dec = [NSString stringWithFormat:@"%d",(max-min)/10];
    
    CPTXYAxis *y = axisSet.yAxis;
    y.majorIntervalLength             = CPTDecimalFromString(dec); //era 0.5
    y.minorTicksPerInterval           = 0;//era 5
    y.orthogonalCoordinateDecimal = CPTDecimalFromFloat(oneDay);
    
    
    NSNumberFormatter *nrFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    nrFormatter.numberStyle = NSNumberFormatterBehaviorDefault;
    y.labelFormatter = nrFormatter;
    y.labelExclusionRanges = [NSArray arrayWithObjects:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(min -((max-min)/10)) length:CPTDecimalFromFloat(((max-min)/10))], nil];
    
    
    
    // Create a plot that uses the data source method
    //FROM RANGEPLOT TO SCATTER PLOT
    CPTScatterPlot *dataSourceLinePlot = [[[CPTScatterPlot alloc] init] autorelease];
    dataSourceLinePlot.identifier = @"faraFiltre";
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineWidth                             = 3.0f;
    lineStyle.lineColor                             = [CPTColor yellowColor];

    
    [dataSourceLinePlot setDataLineStyle:lineStyle];
    dataSourceLinePlot.dataSource = self;
    [graph addPlot:dataSourceLinePlot];
    
    if(filtreleSuntActive==YES)
    {
    ///second plot - cu filtre
    CPTScatterPlot *dataSourceLinePlot2 = [[[CPTScatterPlot alloc] init] autorelease];
    dataSourceLinePlot2.identifier = @"cuFiltre";
    CPTMutableLineStyle *lineStyle2 = [CPTMutableLineStyle lineStyle];
    lineStyle2.lineWidth                             = 3.0f;
    lineStyle2.lineColor                             = [CPTColor blueColor];
    
    
    [dataSourceLinePlot2 setDataLineStyle:lineStyle2];
     dataSourceLinePlot2.dataSource = self;
    [graph addPlot:dataSourceLinePlot2];
    
    }
}
////////////////////
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    //plotDataFaraFiltre = [[NSArray alloc] initWithObjects:@"1234",@"2000",@"4500",@"3296",@"1274",@"2100",@"4000",@"4300",@"3400",@"5100",@"2351",@"3258",@"6000",@"3811",@"4933",@"2000",@"1300",@"3213",@"2222",@"3333",@"4444",@"1234",@"1111",@"3232",@"1212",@"2121",@"2121",@"2121",@"3000",@"1111",@"4000", nil];
    
    //plotDataCuFiltre = [[NSArray alloc] initWithObjects:@"2351",@"3258",@"6000",@"3811",@"4933",@"2000",@"1300",@"3213",@"2222",@"3333",@"4444",@"1234",@"1111",@"3232",@"1212",@"2121",@"2121",@"2121",@"1234",@"2000",@"4500",@"3296",@"1274",@"2100",@"4000",@"1111",@"4000",@"4300",@"3400",@"5100",@"3000", nil];

    
    
    filters=[[Filtre alloc] initWithNibName:@"Filtre" bundle:nil];
    myAds = [[MyAdsViewController alloc] initWithNibName:@"MyAdsViewController" bundle:nil];
    
    //[self createTheGraph];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(switchToFilter)];
    swipeLeft.numberOfTouchesRequired=1;
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.headerView addGestureRecognizer:swipeLeft]; 
    [swipeLeft release];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(switchToMyAds)];
    swipeRight.numberOfTouchesRequired=1;
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.headerView addGestureRecognizer:swipeRight];
    [swipeRight release];
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

-(void)refreshStats
{
    BOOL filtreAplicate;
    filtreAplicate = NO;
   // if(apdelegate.appSession.filtre==nil){filtreAplicate=NO;NSLog(@"filtrele NU SUNT aplicate");}
   // else{filtreAplicate=YES;NSLog(@"filtre aplicate");}
    
    NSLog(@"IN REFRESH STATS");
    TStatistic * stats = apdelegate.appSession.stats;
    
    NSNumber * pretMediu, * diferenta;
    pretMediu = stats.generalAvgTotal;
    diferenta = stats.generalDif;
    NSLog(@"pret mediu:%f  trendDif:%f",[pretMediu floatValue],[diferenta floatValue]);
   
    
    self.avgAreaPriceLabel.text = [NSString stringWithFormat:@"%d euro", [pretMediu intValue]];
    self.generalAvgPriceLabel.text = self.avgAreaPriceLabel.text;
    float value = [[NSString stringWithFormat:@"%.2f", [diferenta floatValue]] floatValue];
    //[self.trendForAvgAreaPriceButton.titleLabel adjustsFontSizeToFitWidth];//
    
    [self.trendForAvgAreaPriceButton setTitle:[NSString stringWithFormat:@"%.2f%%", [diferenta floatValue]] forState:UIControlStateNormal];
    [self.generalTrendButton setTitle:[NSString stringWithFormat:@"%.2f%%", [diferenta floatValue]] forState:UIControlStateNormal]; 
    

    if(value >0)
    {
        [self.trendForAvgAreaPriceButton setImage:[UIImage imageNamed:@"trendCrescator.png"] forState:UIControlStateNormal];
        [self.generalTrendButton setImage:[UIImage imageNamed:@"trendCrescator.png"] forState:UIControlStateNormal];
    }
    else
    {
        if(value<0)
        {
         [self.trendForAvgAreaPriceButton setImage:[UIImage imageNamed:@"trendDescrescator.png"] forState:UIControlStateNormal];
         [self.generalTrendButton setImage:[UIImage imageNamed:@"trendDescrescator.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.trendForAvgAreaPriceButton setImage:nil forState:UIControlStateNormal];
        }
    }
    
    if(filtreAplicate==YES)
    {
        [self.filtreView setHidden:NO];
        
        self.filterAvgPriceLabel.text = [NSString stringWithFormat:@"%d euro", [stats.filterAvgTotal intValue]];
        
        [self.filterTrendButton setTitle:[NSString stringWithFormat:@"%.2f%%", [stats.filterDif floatValue]] forState:UIControlStateNormal];
        
        
        float value2= [[NSString stringWithFormat:@"%.2f", [stats.filterDif floatValue]] floatValue];
        if (value2 >0)
        {
            [self.filterTrendButton setImage:[UIImage imageNamed:@"trendCrescator.png"] forState:UIControlStateNormal];
            NSLog(@">0");
        }
        else
        {
        if(value2<0)
        {[self.filterTrendButton setImage:[UIImage imageNamed:@"trendDescrescator.png"] forState:UIControlStateNormal];NSLog(@"<0");}
        else{[self.filterTrendButton setImage:nil forState:UIControlStateNormal];NSLog(@"==0");}
        }
        

        
       
        NSArray *prop = [apdelegate.appSession.filtre objectForKey:@"property_type"];
        NSMutableString *tipuriProprietate=[NSMutableString stringWithString:@""];
        for(int x=0;x<prop.count;x++)
        {  if(x>0)
        {[tipuriProprietate appendString:@","];
            
        }
            [
             tipuriProprietate appendString:[[prop objectAtIndex:x] lowercaseString]];
        }
        
        
        NSString * filtreString =[NSString stringWithFormat:@"%@-%@ euro, %@-%@ mp, %@, %@ ",[apdelegate.appSession.filtre objectForKey:@"p_min"],[apdelegate.appSession.filtre objectForKey:@"p_max"],[apdelegate.appSession.filtre objectForKey:@"size_min"],[apdelegate.appSession.filtre objectForKey:@"size_max"],[apdelegate.appSession.filtre objectForKey:@"ad_type"],tipuriProprietate];
        
        self.filtreLabel.text = filtreString;                      
                                  
    
    }
    else
    {
        [self.filtreView setHidden:YES];
    }
    
    
    //refresh data
    [self loadPlotData:filtreAplicate];
    
    //refreshchart
    [self createTheGraph:filtreAplicate];
}
-(void)loadPlotData:(BOOL)filtreleSuntActive
{

    min=300000;
    max=0;
    
    
   self.plotDataFaraFiltre = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSLog(@"PLOT DATA gol: %@", self.plotDataFaraFiltre);
    
    if([[apdelegate.appSession.stats generalAvg] count]!=0)
    {
        NSArray * generalDataArray= [apdelegate.appSession.stats generalAvg]; ;
               
    for (int x=0; x<[generalDataArray count]; x++)
    {
        int aux = [[[generalDataArray objectAtIndex:x] objectForKey:@"pos"]intValue];
        NSLog(@"ziua: %d", aux);
        NSString * pret = [NSString stringWithFormat:@"%d", [[[generalDataArray objectAtIndex:x] objectForKey:@"price"] intValue]];
        [self.plotDataFaraFiltre replaceObjectAtIndex:aux withObject:pret];
        //[plotDataFaraFiltre insertObject:pret atIndex:aux];
        //[plotDataFaraFiltre removeObjectAtIndex:aux+1];
        NSLog(@"PETUL din Dict: %d",[pret intValue]);
        NSLog(@"PRETUL: %@",[self.plotDataFaraFiltre objectAtIndex:aux]);
        
        
        if([pret intValue]<min){min=[pret intValue];}
        if([pret intValue]>max){max=[pret intValue];}
    }
         
     NSLog(@"PLOT DATA plin: %@", self.plotDataFaraFiltre);
    }
   
    
    ///////// Cu filtre/////////
    if(filtreleSuntActive==YES)
    {
        self.plotDataCuFiltre = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
        
        if([[apdelegate.appSession.stats filterAvg] count]!=0)
        {
            NSArray * filterDataArray= [apdelegate.appSession.stats filterAvg]; ;
            
            for (int x=0; x<[filterDataArray count]; x++)
            {
                int aux = [[[filterDataArray objectAtIndex:x] objectForKey:@"pos"]intValue];
                NSLog(@"<<FILTRE>>ziua: %d", aux);
                NSString * pret = [NSString stringWithFormat:@"%d", [[[filterDataArray objectAtIndex:x] objectForKey:@"price"] intValue]];
                [self.plotDataCuFiltre replaceObjectAtIndex:aux withObject:pret];
                //[plotDataFaraFiltre insertObject:pret atIndex:aux];
                //[plotDataFaraFiltre removeObjectAtIndex:aux+1];
                NSLog(@"<<FILTRE>>PRETUL din Dict: %d",[pret intValue]);
                NSLog(@"<<FILTRE>>PRETUL: %@",[self.plotDataCuFiltre objectAtIndex:aux]);
                
                
                if([pret intValue]<min){min=[pret intValue];}
                if([pret intValue]>max){max=[pret intValue];}
            }
            
            NSLog(@"<<FILTRE>>PLOT DATA plin: %@", self.plotDataCuFiltre);
        }    
    }    
    
    
    //min=min -3000;
    max=max+3500;
}


-(void) dealloc
{
    [plotDataFaraFiltre release];
    [plotDataCuFiltre release];
    [graph release];
    [areaFill release];
    [barLineStyle release];
    [avgAreaPriceLabel release];
    [trendForAvgAreaPriceButton release];
    [headerView release];
    [filters release];
    [myAds release];
    [generalAvgPriceLabel release];
    [filterAvgPriceLabel release];
    [generalTrendButton release];
    [filterTrendButton release];
    [filtreView release];
    [filtreLabel release];
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
