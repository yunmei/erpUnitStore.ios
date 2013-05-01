//
//  SellChartViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-24.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "SellChartViewController.h"
#import "GoodsSellListViewController.h"

@interface SellChartViewController ()

@end

@implementation SellChartViewController
@synthesize monthDataArray = _monthDataArray;
@synthesize dayDataArray = _dayDataArray;
@synthesize quarterDataArray = _quarterDataArray;
@synthesize yearDataArray = _yearDataArray;
@synthesize weekDataArray = _weekDataArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // UIScrollView *scrollViewForSelf = self.view;
    [(UIScrollView *)self.view setContentSize:CGSizeMake(320, 840)];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bj.png"]];
    self.navigationItem.title = @"销售图表";
    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backVC:)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    //绘制第一个
    //日销售lable
    UILabel *todayLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 18, 80, 20)];
    [todayLabel setText:@"日销售量"];
    [todayLabel setTextColor:[UIColor whiteColor]];
    [todayLabel setBackgroundColor:[UIColor clearColor]];
    [todayLabel setFont:[UIFont systemFontOfSize:17.0]];
    [self.view addSubview:todayLabel];
    UILabel *daySingleDataLable = [[UILabel alloc]initWithFrame:CGRectMake(170, 19, 150, 20)];
    [daySingleDataLable setText:[NSString stringWithFormat:@"昨日 : %@  今日 : %@",@"50",@"20"]];
    [daySingleDataLable setTextColor:[UIColor whiteColor]];
    [daySingleDataLable setBackgroundColor:[UIColor clearColor]];
    [daySingleDataLable setFont:[UIFont systemFontOfSize:14.0]];
    [self.view addSubview:daySingleDataLable];
    //周销售lable
    UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 180, 80, 20)];
    [weekLabel setText:@"周销售量"];
    [weekLabel setTextColor:[UIColor whiteColor]];
    [weekLabel setBackgroundColor:[UIColor clearColor]];
    [weekLabel setFont:[UIFont systemFontOfSize:17.0]];
    [self.view addSubview:weekLabel];
    UILabel *weekSingleDataLable = [[UILabel alloc]initWithFrame:CGRectMake(170, 183, 150, 20)];
    [weekSingleDataLable setText:[NSString stringWithFormat:@"上周 : %@  本周 : %@",@"50",@"20"]];
    [weekSingleDataLable setTextColor:[UIColor whiteColor]];
    [weekSingleDataLable setBackgroundColor:[UIColor clearColor]];
    [weekSingleDataLable setFont:[UIFont systemFontOfSize:14.0]];
    [self.view addSubview:weekSingleDataLable];
    //月销售lable
    UILabel *monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 340, 80, 20)];
    [monthLabel setText:@"月销售量"];
    [monthLabel setTextColor:[UIColor whiteColor]];
    [monthLabel setBackgroundColor:[UIColor clearColor]];
    [monthLabel setFont:[UIFont systemFontOfSize:17.0]];
    [self.view addSubview:monthLabel];
    UILabel *monthSingleDataLable = [[UILabel alloc]initWithFrame:CGRectMake(170, 343, 150, 20)];
    [monthSingleDataLable setText:[NSString stringWithFormat:@"上月 : %@  本月 : %@",@"50",@"20"]];
    [monthSingleDataLable setTextColor:[UIColor whiteColor]];
    [monthSingleDataLable setBackgroundColor:[UIColor clearColor]];
    [monthSingleDataLable setFont:[UIFont systemFontOfSize:14.0]];
    [self.view addSubview:monthSingleDataLable];
    //季度销售量
    UILabel *quarterLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 500, 100, 20)];
    [quarterLabel setText:@"季度销售量"];
    [quarterLabel setTextColor:[UIColor whiteColor]];
    [quarterLabel setBackgroundColor:[UIColor clearColor]];
    [quarterLabel setFont:[UIFont systemFontOfSize:17.0]];
    [self.view addSubview:quarterLabel];
    UILabel *quarterSingleDataLable = [[UILabel alloc]initWithFrame:CGRectMake(170, 502, 150, 20)];
    [quarterSingleDataLable setText:[NSString stringWithFormat:@"上季度 : %@  本季度 : %@",@"50",@"20"]];
    [quarterSingleDataLable setTextColor:[UIColor whiteColor]];
    [quarterSingleDataLable setBackgroundColor:[UIColor clearColor]];
    [quarterSingleDataLable setFont:[UIFont systemFontOfSize:14.0]];
    [self.view addSubview:quarterSingleDataLable];
    //年销量
    UILabel *yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 680, 80, 20)];
    [yearLabel setText:@"年销售量"];
    [yearLabel setTextColor:[UIColor whiteColor]];
    [yearLabel setBackgroundColor:[UIColor clearColor]];
    [yearLabel setFont:[UIFont systemFontOfSize:17.0]];
    [self.view addSubview:yearLabel];
    UILabel *yearSingleDataLable = [[UILabel alloc]initWithFrame:CGRectMake(170, 682, 150, 20)];
    [yearSingleDataLable setText:[NSString stringWithFormat:@"去年 : %@  今年 : %@",@"50",@"20"]];
    [yearSingleDataLable setTextColor:[UIColor whiteColor]];
    [yearSingleDataLable setBackgroundColor:[UIColor clearColor]];
    [yearSingleDataLable setFont:[UIFont systemFontOfSize:14.0]];
    [self.view addSubview:yearSingleDataLable];
    UIImageView *dayImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 300 , 120)];
   [dayImgView setImage:[UIImage imageNamed:@"tj_bj.png"]];
    //图形要放在一个 CPTGraphHostingView 中，CPTGraphHostingView 继承自 UIView
    CPTGraphHostingView *dayHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, 300 , 120)];
    //把 CPTGraphHostingView 加到你自己的 View 中
    [dayImgView addSubview:dayHostView];
    dayHostView.backgroundColor = [UIColor clearColor];
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 40, 300 , 120)];
    btn1.backgroundColor = [UIColor clearColor];
    [btn1 addTarget:self action:@selector(dayPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dayImgView];
    [self.view addSubview:btn1];
      //绘制曲线图
    CPTXYGraph *dayGrahp = [[CPTXYGraph alloc]initWithFrame:dayHostView.bounds];
    dayHostView.hostedGraph = dayGrahp;
    [self setGraphParam:dayGrahp hostView:dayHostView identifier:DAYDATA];
    
    //绘制第二个
    UIImageView *weekImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 200, 300 , 120)];
    [weekImgView setImage:[UIImage imageNamed:@"tj_bj.png"]];
    //图形要放在一个 CPTGraphHostingView 中，CPTGraphHostingView 继承自 UIView
    CPTGraphHostingView *weekHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, 300 , 120)];
    //把 CPTGraphHostingView 加到你自己的 View 中
    [weekImgView addSubview:weekHostView];
    weekHostView.backgroundColor = [UIColor clearColor];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(10, 200, 300 , 120)];
    btn2.backgroundColor = [UIColor clearColor];
    [btn2 addTarget:self action:@selector(weekPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weekImgView];
    [self.view addSubview:btn2];
    //绘制曲线图
    CPTXYGraph *weekGrahp = [[CPTXYGraph alloc]initWithFrame:weekHostView.bounds];
    weekHostView.hostedGraph = weekGrahp;
    [self setGraphParam:weekGrahp hostView:weekHostView identifier:WEEKDATA];
    
    //绘制第三个
    UIImageView *monthImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 360, 300 , 120)];
    [monthImgView setImage:[UIImage imageNamed:@"tj_bj.png"]];
    //图形要放在一个 CPTGraphHostingView 中，CPTGraphHostingView 继承自 UIView
    CPTGraphHostingView *monthHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, 300 , 120)];
    //把 CPTGraphHostingView 加到你自己的 View 中
    [monthImgView addSubview:monthHostView];
    monthHostView.backgroundColor = [UIColor clearColor];
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(10, 360, 300 , 120)];
    btn3.backgroundColor = [UIColor clearColor];
    [btn3 addTarget:self action:@selector(monthPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:monthImgView];
    [self.view addSubview:btn3];
    //绘制曲线图
    CPTXYGraph *monthGrahp = [[CPTXYGraph alloc]initWithFrame:monthImgView.bounds];
    monthHostView.hostedGraph = monthGrahp;
    [self setGraphParam:monthGrahp hostView:monthHostView identifier:MONTHDATA];
    
    //绘制第四个
    UIImageView *quarterImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 520, 300 , 120)];
    [quarterImgView setImage:[UIImage imageNamed:@"tj_bj.png"]];
    //图形要放在一个 CPTGraphHostingView 中，CPTGraphHostingView 继承自 UIView
    CPTGraphHostingView *quarterHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, 300 , 120)];
    //把 CPTGraphHostingView 加到你自己的 View 中
    [quarterImgView addSubview:quarterHostView];
    quarterHostView.backgroundColor = [UIColor clearColor];
    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(10, 520, 300 , 120)];
    btn4.backgroundColor = [UIColor clearColor];
    [btn4 addTarget:self action:@selector(quarterPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quarterImgView];
    [self.view addSubview:btn4];
    //绘制曲线图
    CPTXYGraph *quarterGrahp = [[CPTXYGraph alloc]initWithFrame:weekHostView.bounds];
    quarterHostView.hostedGraph = quarterGrahp;
    [self setGraphParam:quarterGrahp hostView:quarterHostView identifier:QUARTERDATA];
    
    //绘制第五个
    UIImageView *yearImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 700, 300 , 120)];
    [yearImgView setImage:[UIImage imageNamed:@"tj_bj.png"]];
    //图形要放在一个 CPTGraphHostingView 中，CPTGraphHostingView 继承自 UIView
    CPTGraphHostingView *yearHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, 300 , 120)];
    //把 CPTGraphHostingView 加到你自己的 View 中
    [yearImgView addSubview:yearHostView];
    yearHostView.backgroundColor = [UIColor clearColor];
    UIButton *btn5 = [[UIButton alloc]initWithFrame:CGRectMake(10, 700, 300 , 120)];
    btn5.backgroundColor = [UIColor clearColor];
    [btn5 addTarget:self action:@selector(yearPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yearImgView];
    [self.view addSubview:btn5];
    //绘制曲线图
    CPTXYGraph *yearGrahp = [[CPTXYGraph alloc]initWithFrame:weekHostView.bounds];
    yearHostView.hostedGraph = yearGrahp;
    [self setGraphParam:yearGrahp hostView:yearHostView identifier:YEARDATA];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回
- (void)backVC:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    if([plot.identifier isEqual:DAYDATA])
    {
        NSLog(@"identifierday%@",plot.identifier);
        if(fieldEnum == CPTScatterPlotFieldX)
        {
            return [NSNumber numberWithInt:index+1];
        }else{
            return [self.dayDataArray objectAtIndex:index];
        }
    }else if ([plot.identifier isEqual:WEEKDATA]){
         NSLog(@"identifierweek%@",plot.identifier);
        if(fieldEnum == CPTScatterPlotFieldX)
        {
            return [NSNumber numberWithInt:index+1];
        }else{
            return [self.weekDataArray objectAtIndex:index];
        }    
    }else if ([plot.identifier isEqual:MONTHDATA]){
         NSLog(@"identifiermonth%@",plot.identifier);
        if(fieldEnum == CPTScatterPlotFieldX)
        {
            return [NSNumber numberWithInt:index+1];
        }else{
            return [self.monthDataArray objectAtIndex:index];
        } 
    }else if ([plot.identifier isEqual:QUARTERDATA]){
          NSLog(@"identifierquart%@",plot.identifier);
        if(fieldEnum == CPTScatterPlotFieldX)
        {
            return [NSNumber numberWithInt:index+1];
        }else{
            return [self.quarterDataArray objectAtIndex:index];
        }
    }else{
         NSLog(@"511");
        if(fieldEnum == CPTScatterPlotFieldX)
        {
            return [NSNumber numberWithInt:index+1];
        }else{
            return [self.yearDataArray objectAtIndex:index];
        }
    }


}

 - (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    
    if([plot.identifier isEqual:DAYDATA])
    {
        return [self.dayDataArray count];
    }else if ([plot.identifier isEqual:WEEKDATA]){
        return [self.weekDataArray count];
    }else if ([plot.identifier isEqual:MONTHDATA]){
        return [self.monthDataArray count];
    }else if ([plot.identifier isEqual:QUARTERDATA]){
        return [self.quarterDataArray count];
    }else{
        return [self.yearDataArray count];
    }

}

- (void)setGraphParam:(CPTXYGraph *)graph
             hostView:(CPTGraphHostingView *)hostView
           identifier:(NSString *)identifier
{

    CPTScatterPlot *scatterPlot = [[CPTScatterPlot alloc]initWithFrame:hostView.frame];
    
    //设置坐标轴大小
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    if([identifier isEqualToString:DAYDATA])
    {
        plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.5) length:CPTDecimalFromFloat(27)];
        plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-1) length:CPTDecimalFromFloat(100)];
    }else if ([identifier isEqualToString:WEEKDATA]){
        plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.5) length:CPTDecimalFromFloat(8)];
        plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(100)];
    }else if ([identifier isEqualToString:MONTHDATA]){
        plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-1) length:CPTDecimalFromFloat(32)];
        plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-1) length:CPTDecimalFromFloat(100)];
    }else if ([identifier isEqualToString:QUARTERDATA]){
        plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.5) length:CPTDecimalFromFloat(3.2)];
        plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-1) length:CPTDecimalFromFloat(100)];
    }else if ([identifier isEqualToString:YEARDATA]){
        plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.5) length:CPTDecimalFromFloat(13)];
        plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(100)];
    }

    scatterPlot.identifier = identifier;
    scatterPlot.dataSource = self;
    
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit = 1.0f;
    lineStyle.lineWidth = 2.0f;
    [graph addPlot:scatterPlot];
    graph.paddingLeft = 5;
	graph.paddingTop = 5;
	graph.paddingRight = 5;
	graph.paddingBottom = 5;
    
    graph.plotAreaFrame.paddingLeft = 25.0 ;
    graph.plotAreaFrame.paddingTop = 10 ;
    graph.plotAreaFrame.paddingRight = 5.0 ;
    graph.plotAreaFrame.paddingBottom = 20.0 ;
    //设置坐标轴
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x = axisSet.xAxis;
    //清除默认标签轴，使用自定义标签
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    //自定义轴标签数组，放置自定义数组
    NSMutableArray *lableArray = [[NSMutableArray alloc]init];

    if([identifier isEqualToString:DAYDATA])
    {
        lineStyle.lineColor = [CPTColor colorWithComponentRed:1 green:128/255.0 blue:0 alpha:1.0];;
        scatterPlot.dataLineStyle = lineStyle;
        //构造一个textStyle
        static CPTTextStyle *lableTextStyle = nil;
        lableTextStyle = [[CPTTextStyle alloc]init];
        lableTextStyle.color = [CPTColor colorWithComponentRed:1 green:128/255.0 blue:0 alpha:1.0];
        lableTextStyle.fontSize = 10.f;
        lableTextStyle.textAlignment = CPTTextAlignmentCenter;
        int count =0;
        for(int i =0;i<26;i +=4)
        {
           // CPTAxisLable *newlable1 = [CPTAxisLabel alloc]ini
            CPTAxisLabel *newLable = [[CPTAxisLabel alloc]initWithText:[NSString stringWithFormat:@"%i",i] textStyle:lableTextStyle];
            newLable.tickLocation = CPTDecimalFromInt(count*4);
            newLable.offset = x.labelOffset + x.majorTickLength;
            // newLable.rotation = M_1_PI/2;
            [lableArray addObject:newLable];
            count ++;
        }
        x.axisLabels = [NSSet setWithArray:lableArray];
        //最大刻度线 2单位
        x.majorIntervalLength = CPTDecimalFromString(@"10");
        //坐标圆点
        x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
        //不显示最小刻度线
        x.minorTickLineStyle = nil;
        x.majorTickLineStyle = nil;
        x.axisLineStyle = nil;
        CPTXYAxis *y = axisSet.yAxis;
        //  y.axisLineStyle = nil;
        
        y.majorIntervalLength = CPTDecimalFromString(@"30");
        y.minorTickLineStyle = nil;
        y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0.8");
        y.minorTickLineStyle = nil;
        y.majorTickLineStyle = nil;
        y.axisLineStyle = nil;
        y.labelTextStyle.color = [CPTColor colorWithComponentRed:1 green:128/255.0 blue:0 alpha:1.0];;
        y.labelTextStyle.fontSize = 10.f;
        //设置小圆点
        //symbleLineStyle.lineColor = [CPTColor blackColor];
        CPTPlotSymbol *plotSymbol = [ CPTPlotSymbol ellipsePlotSymbol ];
        plotSymbol. fill = [ CPTFill fillWithColor :[CPTColor colorWithComponentRed:1 green:128/255.0 blue:0 alpha:1.0]];
        plotSymbol. lineStyle = nil;
        plotSymbol. size = CGSizeMake ( 5.0 , 5.0 );
        scatterPlot.plotSymbol = plotSymbol;

    }else if ([identifier isEqualToString:WEEKDATA]){
        lineStyle.lineColor = [CPTColor colorWithComponentRed:0 green:165/255.0 blue:250/255.0 alpha:1.0];
        scatterPlot.dataLineStyle = lineStyle;
        //构造一个textStyle
        static CPTTextStyle *lableTextStyle = nil;
        lableTextStyle = [[CPTTextStyle alloc]init];
        lableTextStyle.color = [CPTColor colorWithComponentRed:0 green:165/255.0 blue:250/255.0 alpha:1.0];;
        lableTextStyle.fontSize = 10.f;
        lableTextStyle.textAlignment = CPTTextAlignmentCenter;
        int count =0;
        for(int i =0;i<8;i++)
        {
            CPTAxisLabel *newLable = [[CPTAxisLabel alloc]initWithText:[NSString stringWithFormat:@"%i",i] textStyle:lableTextStyle];
            newLable.tickLocation = CPTDecimalFromInt(count);
            newLable.offset = x.labelOffset + x.majorTickLength;
            // newLable.rotation = M_1_PI/2;
            [lableArray addObject:newLable];
            count ++;
        }
        x.axisLabels = [NSSet setWithArray:lableArray];
        //最大刻度线 2单位
        x.majorIntervalLength = CPTDecimalFromString(@"1");
        //坐标圆点
        x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
        //不显示最小刻度线
        x.minorTickLineStyle = nil;
        x.majorTickLineStyle = nil;
        x.axisLineStyle = nil;
        CPTXYAxis *y = axisSet.yAxis;
        //  y.axisLineStyle = nil;
        
        y.majorIntervalLength = CPTDecimalFromString(@"30");
        y.minorTickLineStyle = nil;
        y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0.8");
        y.minorTickLineStyle = nil;
        y.majorTickLineStyle = nil;
        y.axisLineStyle = nil;
        y.labelTextStyle.color = [CPTColor colorWithComponentRed:0 green:165/255.0 blue:250/255.0 alpha:1.0];
        y.labelTextStyle.fontSize = 10.f;
        //设置小圆点
        //symbleLineStyle.lineColor = [CPTColor blackColor];
        CPTPlotSymbol *plotSymbol = [ CPTPlotSymbol ellipsePlotSymbol ];
        plotSymbol. fill = [ CPTFill fillWithColor :[CPTColor colorWithComponentRed:0 green:165/255.0 blue:250/255.0 alpha:1.0]];
        plotSymbol. lineStyle = nil;
        plotSymbol. size = CGSizeMake ( 5.0 , 5.0 );
        scatterPlot.plotSymbol = plotSymbol;

    }else if ([identifier isEqualToString:MONTHDATA]){
        lineStyle.lineColor = [CPTColor colorWithComponentRed:241/255.0 green:47/255.0 blue:30/255.0 alpha:1.0];
        scatterPlot.dataLineStyle = lineStyle;
        //构造一个textStyle
        static CPTTextStyle *lableTextStyle = nil;
        lableTextStyle = [[CPTTextStyle alloc]init];
        lableTextStyle.color = [CPTColor colorWithComponentRed:241/255.0 green:47/255.0 blue:30/255.0 alpha:1.0];
        lableTextStyle.fontSize = 10.f;
        lableTextStyle.textAlignment = CPTTextAlignmentCenter;
        int count =0;
        for(int i =0;i<30;i +=5)
        {
            CPTAxisLabel *newLable = [[CPTAxisLabel alloc]initWithText:[NSString stringWithFormat:@"%i",i] textStyle:lableTextStyle];
            newLable.tickLocation = CPTDecimalFromInt(count*5);
            newLable.offset = x.labelOffset + x.majorTickLength;
            // newLable.rotation = M_1_PI/2;
            [lableArray addObject:newLable];
            count ++;
        }
        x.axisLabels = [NSSet setWithArray:lableArray];
        //最大刻度线 2单位
        x.majorIntervalLength = CPTDecimalFromString(@"10");
        //坐标圆点
        x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
        //不显示最小刻度线
        x.minorTickLineStyle = nil;
        x.majorTickLineStyle = nil;
        x.axisLineStyle = nil;
        CPTXYAxis *y = axisSet.yAxis;
        //  y.axisLineStyle = nil;
        
        y.majorIntervalLength = CPTDecimalFromString(@"30");
        y.minorTickLineStyle = nil;
        y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
        y.minorTickLineStyle = nil;
        y.majorTickLineStyle = nil;
        y.axisLineStyle = nil;
        y.labelTextStyle.color = [CPTColor colorWithComponentRed:241/255.0 green:47/255.0 blue:30/255.0 alpha:1.0];
        y.labelTextStyle.fontSize = 10.f;
        //设置小圆点
        //symbleLineStyle.lineColor = [CPTColor blackColor];
        CPTPlotSymbol *plotSymbol = [ CPTPlotSymbol ellipsePlotSymbol ];
        plotSymbol. fill = [ CPTFill fillWithColor :[CPTColor colorWithComponentRed:241/255.0 green:47/255.0 blue:30/255.0 alpha:1.0]];
        plotSymbol. lineStyle = nil;
        plotSymbol. size = CGSizeMake ( 5.0 , 5.0 );
        scatterPlot.plotSymbol = plotSymbol;

    }else if ([identifier isEqualToString:QUARTERDATA]){
        lineStyle.lineColor = [CPTColor colorWithComponentRed:115/255.0 green:156/255.0 blue:50/255.0 alpha:1.0];
        scatterPlot.dataLineStyle = lineStyle;
        //构造一个textStyle
        static CPTTextStyle *lableTextStyle = nil;
        lableTextStyle = [[CPTTextStyle alloc]init];
        lableTextStyle.color = [CPTColor colorWithComponentRed:115/255.0 green:156/255.0 blue:50/255.0 alpha:1.0];
        lableTextStyle.fontSize = 10.f;
        lableTextStyle.textAlignment = CPTTextAlignmentCenter;
        int count =0;
        for(int i =0;i<5;i ++)
        {
            CPTAxisLabel *newLable = [[CPTAxisLabel alloc]initWithText:[NSString stringWithFormat:@"%i",i] textStyle:lableTextStyle];
            newLable.tickLocation = CPTDecimalFromInt(count);
            newLable.offset = x.labelOffset + x.majorTickLength;
            // newLable.rotation = M_1_PI/2;
            [lableArray addObject:newLable];
            count ++;
        }
        x.axisLabels = [NSSet setWithArray:lableArray];
        //最大刻度线 2单位
        x.majorIntervalLength = CPTDecimalFromString(@"1");
        //坐标圆点
        x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
        //不显示最小刻度线
        x.minorTickLineStyle = nil;
        x.majorTickLineStyle = nil;
        x.axisLineStyle = nil;
        CPTXYAxis *y = axisSet.yAxis;
        //  y.axisLineStyle = nil;
        
        y.majorIntervalLength = CPTDecimalFromString(@"30");
        y.minorTickLineStyle = nil;
        y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0.8");
        y.minorTickLineStyle = nil;
        y.majorTickLineStyle = nil;
        y.axisLineStyle = nil;
        y.labelTextStyle.color = [CPTColor colorWithComponentRed:115/255.0 green:156/255.0 blue:50/255.0 alpha:1.0];
        y.labelTextStyle.fontSize = 10.f;
        //设置小圆点
        //symbleLineStyle.lineColor = [CPTColor blackColor];
        CPTPlotSymbol *plotSymbol = [ CPTPlotSymbol ellipsePlotSymbol ];
        plotSymbol. fill = [ CPTFill fillWithColor :[CPTColor colorWithComponentRed:115/255.0 green:156/255.0 blue:50/255.0 alpha:1.0]];
        plotSymbol. lineStyle = nil;
        plotSymbol. size = CGSizeMake ( 5.0 , 5.0 );
        scatterPlot.plotSymbol = plotSymbol;

    }else{
        lineStyle.lineColor = [CPTColor blueColor];
        scatterPlot.dataLineStyle = lineStyle;
        //构造一个textStyle
        static CPTTextStyle *lableTextStyle = nil;
        lableTextStyle = [[CPTTextStyle alloc]init];
        lableTextStyle.color = [CPTColor blueColor];
        lableTextStyle.fontSize = 10.f;
        lableTextStyle.textAlignment = CPTTextAlignmentCenter;
        int count =0;
        for(int i =0;i<13;i ++)
        {
            CPTAxisLabel *newLable = [[CPTAxisLabel alloc]initWithText:[NSString stringWithFormat:@"%i",i*2] textStyle:lableTextStyle];
            newLable.tickLocation = CPTDecimalFromInt(count*2);
            newLable.offset = x.labelOffset + x.majorTickLength;
            // newLable.rotation = M_1_PI/2;
            [lableArray addObject:newLable];
            count ++;
        }
        x.axisLabels = [NSSet setWithArray:lableArray];
        //最大刻度线 2单位
        x.majorIntervalLength = CPTDecimalFromString(@"2");
        //坐标圆点
        x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
        //不显示最小刻度线
        x.minorTickLineStyle = nil;
        x.majorTickLineStyle = nil;
        x.axisLineStyle = nil;
        CPTXYAxis *y = axisSet.yAxis;
        //  y.axisLineStyle = nil;
        
        y.majorIntervalLength = CPTDecimalFromString(@"30");
        y.minorTickLineStyle = nil;
        y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0.8");
        y.minorTickLineStyle = nil;
        y.majorTickLineStyle = nil;
        y.axisLineStyle = nil;
        y.labelTextStyle.color = [CPTColor blueColor];
        y.labelTextStyle.fontSize = 10.f;
        //设置小圆点
        //symbleLineStyle.lineColor = [CPTColor blackColor];
        CPTPlotSymbol *plotSymbol = [ CPTPlotSymbol ellipsePlotSymbol ];
        plotSymbol. fill = [ CPTFill fillWithColor :[ CPTColor blueColor ]];
        plotSymbol. lineStyle = nil;
        plotSymbol. size = CGSizeMake ( 5.0 , 5.0 );
        scatterPlot.plotSymbol = plotSymbol;
    }
}

//日
- (NSMutableArray *)dayDataArray
{
    if(_dayDataArray == nil)
    {
        _dayDataArray = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:30],[NSNumber numberWithInt:33],[NSNumber numberWithInt:50],[NSNumber numberWithInt:65],[NSNumber numberWithInt:85],[NSNumber numberWithInt:70],[NSNumber numberWithInt:23],[NSNumber numberWithInt:34],[NSNumber numberWithInt:65],[NSNumber numberWithInt:77],[NSNumber numberWithInt:45],[NSNumber numberWithInt:48],[NSNumber numberWithInt:66],[NSNumber numberWithInt:25],[NSNumber numberWithInt:37],[NSNumber numberWithInt:32],[NSNumber numberWithInt:72],[NSNumber numberWithInt:13],[NSNumber numberWithInt:23],[NSNumber numberWithInt:87],[NSNumber numberWithInt:27],[NSNumber numberWithInt:60],[NSNumber numberWithInt:66],[NSNumber numberWithInt:8], nil];
    }
    return _dayDataArray;
}

//yue
- (NSMutableArray *)monthDataArray
{
    if(_monthDataArray == nil)
    {
        _monthDataArray = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:30],[NSNumber numberWithInt:33],[NSNumber numberWithInt:50],[NSNumber numberWithInt:65],[NSNumber numberWithInt:85],[NSNumber numberWithInt:70],[NSNumber numberWithInt:23],[NSNumber numberWithInt:34],[NSNumber numberWithInt:65],[NSNumber numberWithInt:77],[NSNumber numberWithInt:45],[NSNumber numberWithInt:48],[NSNumber numberWithInt:66],[NSNumber numberWithInt:25],[NSNumber numberWithInt:37],[NSNumber numberWithInt:32],[NSNumber numberWithInt:72],[NSNumber numberWithInt:13],[NSNumber numberWithInt:23],[NSNumber numberWithInt:87],[NSNumber numberWithInt:27],[NSNumber numberWithInt:60],[NSNumber numberWithInt:66],[NSNumber numberWithInt:8],[NSNumber numberWithInt:55],[NSNumber numberWithInt:15],[NSNumber numberWithInt:35],[NSNumber numberWithInt:89],[NSNumber numberWithInt:56],[NSNumber numberWithInt:14], nil];
    }
    return _monthDataArray;
}

//zhou
- (NSMutableArray *)weekDataArray
{
    if(_weekDataArray == nil)
    {
        _weekDataArray = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:30],[NSNumber numberWithInt:33],[NSNumber numberWithInt:50],[NSNumber numberWithInt:65],[NSNumber numberWithInt:85],[NSNumber numberWithInt:70],[NSNumber numberWithInt:23], nil];
    }
    return _weekDataArray;
}

//jidu
- (NSMutableArray *)quarterDataArray
{
    if(_quarterDataArray == nil)
    {
        _quarterDataArray = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:70],[NSNumber numberWithInt:33],[NSNumber numberWithInt:50],nil];
    }
    return _quarterDataArray;
}

//nian
//jidu
- (NSMutableArray *)yearDataArray
{
    if(_yearDataArray == nil)
    {
        _yearDataArray = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:70],[NSNumber numberWithInt:33],[NSNumber numberWithInt:12],[NSNumber numberWithInt:54],[NSNumber numberWithInt:31],[NSNumber numberWithInt:66],[NSNumber numberWithInt:18],[NSNumber numberWithInt:65],[NSNumber numberWithInt:60],[NSNumber numberWithInt:70],[NSNumber numberWithInt:78],[NSNumber numberWithInt:44],nil];
    }
    return _yearDataArray;
}

- (void)dayPressed:(id)sender
{
    //格式化时间
    NSTimeInterval secondsPerDay = 26*60*60;
    NSDate *onDayBefore = [[NSDate alloc]initWithTimeIntervalSinceNow:-secondsPerDay];
    NSDate *twoDayBefore = [[NSDate alloc]initWithTimeIntervalSinceNow:-2*secondsPerDay];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  twoDayBeforeString = [dateformatter stringFromDate:twoDayBefore];
    NSString *  oneDayBeforeString = [dateformatter stringFromDate:onDayBefore];
    NSString *dateAppend = [NSString stringWithFormat:@"%@|%@",twoDayBeforeString,oneDayBeforeString];
    NSLog(@"dateAppend%@",dateAppend);
    MKNetworkEngine *engine = [YMGlobal getEngine];
    MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
   // NSString *apiparamString = [NSString stringWithFormat:@"\\\"date_range\\\":\\\"%@\\\",\\\"ordertype\\\":\\\"sell\\\"",dateAppend];
    NSString *apiparamString = [NSString stringWithFormat:@"\\\"date_range\\\":\\\"2012-1-1|2013-3-28\\\",\\\"ordertype\\\":\\\"sell\\\""];
    op = [YMGlobal setOperationParams:@"Get.AllGoodsSaleList" apiparam:apiparamString execOp:op];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJson_Parser *parser = [[SBJson_Parser alloc]init];
        NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
        if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
        {
            NSMutableArray *bodyArray = [parser objectWithString:[data objectForKey:@"body"]];
            GoodsSellListViewController *goodsSellListVC = [[GoodsSellListViewController alloc]init];
            goodsSellListVC.goodsSellInformationArray = bodyArray;
            [self.navigationController pushViewController:goodsSellListVC animated:YES];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"error%@",[completedOperation responseString]);
    }];
    [engine enqueueOperation:op];
}
- (void)weekPressed:(id)sender
{
    //格式化时间
    NSTimeInterval secondsPerDay = 26*60*60;
    NSDate *onDayBefore = [[NSDate alloc]initWithTimeIntervalSinceNow:-secondsPerDay];
    NSDate *sevenDayBefore = [[NSDate alloc]initWithTimeIntervalSinceNow:-7*secondsPerDay];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  sevenDayBeforeString = [dateformatter stringFromDate:sevenDayBefore];
    NSString *  oneDayBeforeString = [dateformatter stringFromDate:onDayBefore];
    NSString *dateAppend = [NSString stringWithFormat:@"%@|%@",sevenDayBeforeString,oneDayBeforeString];
    NSLog(@"dateAppend%@",dateAppend);
    MKNetworkEngine *engine = [YMGlobal getEngine];
    MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
    NSString *apiparamString = [NSString stringWithFormat:@"\\\"date_range\\\":\\\"%@\\\",\\\"ordertype\\\":\\\"sell\\\"",dateAppend];
    op = [YMGlobal setOperationParams:@"Get.AllGoodsSaleList" apiparam:apiparamString execOp:op];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJson_Parser *parser = [[SBJson_Parser alloc]init];
        NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
        if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
        {
            NSMutableArray *bodyArray = [parser objectWithString:[data objectForKey:@"body"]];
            GoodsSellListViewController *goodsSellListVC = [[GoodsSellListViewController alloc]init];
            goodsSellListVC.goodsSellInformationArray = bodyArray;
            [self.navigationController pushViewController:goodsSellListVC animated:YES];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"error%@",[completedOperation responseString]);
    }];
    [engine enqueueOperation:op];
}
- (void)monthPressed:(id)sender
{
    //格式化时间
    NSTimeInterval secondsPerDay = 26*60*60;
    NSDate *onDayBefore = [[NSDate alloc]initWithTimeIntervalSinceNow:-secondsPerDay];
    NSDate *sevenDayBefore = [[NSDate alloc]initWithTimeIntervalSinceNow:-7*secondsPerDay];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  sevenDayBeforeString = [dateformatter stringFromDate:sevenDayBefore];
    NSString *  oneDayBeforeString = [dateformatter stringFromDate:onDayBefore];
    NSString *dateAppend = [NSString stringWithFormat:@"%@|%@",sevenDayBeforeString,oneDayBeforeString];
    NSLog(@"dateAppend%@",dateAppend);
    MKNetworkEngine *engine = [YMGlobal getEngine];
    MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
   // NSString *apiparamString = [NSString stringWithFormat:@"\\\"date_range\\\":\\\"%@\\\",\\\"ordertype\\\":\\\"sell\\\"",dateAppend];
     NSString *apiparamString = [NSString stringWithFormat:@"\\\"date_range\\\":\\\"2012-1-1|2013-3-28\\\",\\\"ordertype\\\":\\\"sell\\\""];
    op = [YMGlobal setOperationParams:@"Get.AllGoodsSaleList" apiparam:apiparamString execOp:op];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJson_Parser *parser = [[SBJson_Parser alloc]init];
        NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
        if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
        {
            NSMutableArray *bodyArray = [parser objectWithString:[data objectForKey:@"body"]];
            GoodsSellListViewController *goodsSellListVC = [[GoodsSellListViewController alloc]init];
            goodsSellListVC.goodsSellInformationArray = bodyArray;
            [self.navigationController pushViewController:goodsSellListVC animated:YES];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"error%@",[completedOperation responseString]);
    }];
    [engine enqueueOperation:op];
}
- (void)quarterPressed:(id)sender
{
    //格式化时间
    NSTimeInterval secondsPerDay = 26*60*60;
    NSDate *onDayBefore = [[NSDate alloc]initWithTimeIntervalSinceNow:-secondsPerDay];
    NSDate *sevenDayBefore = [[NSDate alloc]initWithTimeIntervalSinceNow:-7*secondsPerDay];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  sevenDayBeforeString = [dateformatter stringFromDate:sevenDayBefore];
    NSString *  oneDayBeforeString = [dateformatter stringFromDate:onDayBefore];
    NSString *dateAppend = [NSString stringWithFormat:@"%@|%@",sevenDayBeforeString,oneDayBeforeString];
    NSLog(@"dateAppend%@",dateAppend);
    MKNetworkEngine *engine = [YMGlobal getEngine];
    MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
    //NSString *apiparamString = [NSString stringWithFormat:@"\\\"date_range\\\":\\\"%@\\\",\\\"ordertype\\\":\\\"sell\\\"",dateAppend];
    NSString *apiparamString = [NSString stringWithFormat:@"\\\"date_range\\\":\\\"2012-1-1|2013-3-28\\\",\\\"ordertype\\\":\\\"sell\\\""];
    op = [YMGlobal setOperationParams:@"Get.AllGoodsSaleList" apiparam:apiparamString execOp:op];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJson_Parser *parser = [[SBJson_Parser alloc]init];
        NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
        if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
        {
            NSMutableArray *bodyArray = [parser objectWithString:[data objectForKey:@"body"]];
            GoodsSellListViewController *goodsSellListVC = [[GoodsSellListViewController alloc]init];
            goodsSellListVC.goodsSellInformationArray = bodyArray;
            [self.navigationController pushViewController:goodsSellListVC animated:YES];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"error%@",[completedOperation responseString]);
    }];
    [engine enqueueOperation:op];
}
- (void)yearPressed:(id)sender
{
    //格式化时间
    NSTimeInterval secondsPerDay = 26*60*60;
    NSDate *onDayBefore = [[NSDate alloc]initWithTimeIntervalSinceNow:-secondsPerDay];
    NSDate *sevenDayBefore = [[NSDate alloc]initWithTimeIntervalSinceNow:-7*secondsPerDay];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  sevenDayBeforeString = [dateformatter stringFromDate:sevenDayBefore];
    NSString *  oneDayBeforeString = [dateformatter stringFromDate:onDayBefore];
    NSString *dateAppend = [NSString stringWithFormat:@"%@|%@",sevenDayBeforeString,oneDayBeforeString];
    NSLog(@"dateAppend%@",dateAppend);
    MKNetworkEngine *engine = [YMGlobal getEngine];
    MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
    //NSString *apiparamString = [NSString stringWithFormat:@"\\\"date_range\\\":\\\"%@\\\",\\\"ordertype\\\":\\\"sell\\\"",dateAppend];
    NSString *apiparamString = [NSString stringWithFormat:@"\\\"date_range\\\":\\\"2012-1-1|2013-3-28\\\",\\\"ordertype\\\":\\\"sell\\\""];
    op = [YMGlobal setOperationParams:@"Get.AllGoodsSaleList" apiparam:apiparamString execOp:op];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJson_Parser *parser = [[SBJson_Parser alloc]init];
        NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
        if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
        {
            NSMutableArray *bodyArray = [parser objectWithString:[data objectForKey:@"body"]];
            GoodsSellListViewController *goodsSellListVC = [[GoodsSellListViewController alloc]init];
            goodsSellListVC.goodsSellInformationArray = bodyArray;
            [self.navigationController pushViewController:goodsSellListVC animated:YES];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"error%@",[completedOperation responseString]);
    }];
    [engine enqueueOperation:op];
}
@end
