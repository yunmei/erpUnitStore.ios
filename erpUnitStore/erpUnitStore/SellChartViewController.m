//
//  SellChartViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-24.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "SellChartViewController.h"

@interface SellChartViewController ()

@end

@implementation SellChartViewController
@synthesize monthDataArray;

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
    self.navigationItem.title = @"销售图表";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backVC:)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    //初始化数组，并放入十个 0 － 20 间的随机数
    self.monthDataArray = [[NSMutableArray alloc] init];
    for( int i=0; i< 30; i++){
        [self.monthDataArray addObject:[NSNumber numberWithInt:rand()%20]];
    }
    NSLog(@"%@",self.monthDataArray);
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300 , 100)];
   [imgView setImage:[UIImage imageNamed:@"tj_bj.png"]];
    //图形要放在一个 CPTGraphHostingView 中，CPTGraphHostingView 继承自 UIView
    CPTGraphHostingView *hostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, 300 , 100)];
    //把 CPTGraphHostingView 加到你自己的 View 中
    [imgView addSubview:hostView];
    hostView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imgView];
//    //绘制曲线图
    CPTXYGraph *grahp = [[CPTXYGraph alloc]initWithFrame:hostView.bounds];
    hostView.hostedGraph = grahp;
    
    CPTScatterPlot *scatterPlot = [[CPTScatterPlot alloc]initWithFrame:hostView.frame];
    
    //设置坐标轴大小
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)grahp.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromString(@"-1") length:CPTDecimalFromString(@"33")];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-1) length:CPTDecimalFromFloat(22)];
    scatterPlot.identifier = @"bluePlot";
    scatterPlot.dataSource = self;
    
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit = 1.0f;
    lineStyle.lineWidth = 2.0f;
    lineStyle.lineColor = [CPTColor blueColor];
    scatterPlot.dataLineStyle = lineStyle;
    [grahp addPlot:scatterPlot];
    grahp.paddingLeft = 5;
	grahp.paddingTop = 5;
	grahp.paddingRight = 5;
	grahp.paddingBottom = 5;
    
    grahp.plotAreaFrame.paddingLeft = 25.0 ;
    grahp.plotAreaFrame.paddingTop = 10 ;
    grahp.plotAreaFrame.paddingRight = 5.0 ;
    grahp.plotAreaFrame.paddingBottom = 20.0 ;
    //设置坐标轴
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)grahp.axisSet;
    CPTXYAxis *x = axisSet.xAxis;
    //清除默认标签轴，使用自定义标签
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    //自定义轴标签数组，放置自定义数组
    NSMutableArray *lableArray = [[NSMutableArray alloc]init];
    
    //构造一个textStyle
    static CPTTextStyle *lableTextStyle = nil;
    lableTextStyle = [[CPTTextStyle alloc]init];
    lableTextStyle.color = [CPTColor blueColor];
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
    
    y.majorIntervalLength = CPTDecimalFromString(@"10");
    y.minorTickLineStyle = nil;
    y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
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
    if(fieldEnum == CPTScatterPlotFieldX)
    {
        return [NSNumber numberWithInt:index];
    }else{
        return [self.monthDataArray objectAtIndex:index];
    }
}


 - (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
   return  [self.monthDataArray count];
}

@end
