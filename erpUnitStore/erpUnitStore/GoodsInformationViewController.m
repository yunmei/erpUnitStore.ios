//
//  GoodsInformationViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-27.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "GoodsInformationViewController.h"

@interface GoodsInformationViewController ()

@end

@implementation GoodsInformationViewController
@synthesize sellArray = _sellArray;
@synthesize goodsId;
@synthesize nameLabel;
@synthesize goodsIdLabel;
@synthesize goodsTypeLabel;
@synthesize stockAmountLabel;
@synthesize stockWarnLabel;
@synthesize costPriceLabel;
@synthesize inNunLabel;
@synthesize goodsUnitLabel;
@synthesize standardPriceLabel;
@synthesize monthString;
@synthesize lastYearLabel;
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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bj.png"]]];
    [lastYearLabel setText:[NSString stringWithFormat:@"销售分析 : 去年%@月份销售统计分析",self.monthString]];
    // Do any additional setup after loading the view from its nib.
    //[self.view setBackgroundColor:[UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1.0]];
    //统计图表
    UIImageView *dayImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 300 , 170)];
    [dayImgView setBackgroundColor:[UIColor clearColor]];
    //图形要放在一个 CPTGraphHostingView 中，CPTGraphHostingView 继承自 UIView
    CPTGraphHostingView *dayHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, 300 , 160)];
    //把 CPTGraphHostingView 加到你自己的 View 中
    [dayImgView addSubview:dayHostView];
    dayHostView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:dayImgView];
    //绘制曲线
    CPTXYGraph *dayGrahp = [[CPTXYGraph alloc]initWithFrame:dayHostView.bounds];
    dayHostView.hostedGraph = dayGrahp;
    [self setGraphParam:dayGrahp hostView:dayHostView];
    
    //请求商品信息
    MKNetworkEngine *engine = [YMGlobal getEngine];
    MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
    op = [YMGlobal setOperationParams:@"Get.Inventory" apiparam:[NSString stringWithFormat:@"\\\"Goods_id\\\":\\\"%@\\\"",self.goodsId] execOp:op];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
        if([[data objectForKey:@"errcode"] isEqualToString:@"0"])
        {
            NSMutableDictionary *goodsInfoDictionary = [parser objectWithString:[data objectForKey:@"body"]];
            NSLog(@"goodsInfoDictionary%@",goodsInfoDictionary);
            [self.nameLabel setText:[NSString stringWithFormat:@"%@",[goodsInfoDictionary objectForKey:@"Goods_Name"]]];
            [self.goodsIdLabel setText:[NSString stringWithFormat:@"%@",[goodsInfoDictionary objectForKey:@"Goods_ID"]]];
            [self.stockAmountLabel setText:[NSString stringWithFormat:@"%@",[goodsInfoDictionary objectForKey:@"Stock_Amount"]]];
            [self.stockWarnLabel setText:[NSString stringWithFormat:@"%@",[goodsInfoDictionary objectForKey:@"StockWarn_Amount"]]];
            [self.costPriceLabel setText:[NSString stringWithFormat:@"%@",[goodsInfoDictionary objectForKey:@"Cost_Price"]]];
            [self.goodsTypeLabel setText:[NSString stringWithFormat:@"%@",[goodsInfoDictionary objectForKey:@"Type_Name"]]];
            [self.inNunLabel setText:[NSString stringWithFormat:@"%@",[goodsInfoDictionary objectForKey:@"All_Amount"]]];
            [self.goodsUnitLabel setText:[NSString stringWithFormat:@"%@",[goodsInfoDictionary objectForKey:@"Goods_Unit"]]];
            [self.standardPriceLabel setText:[NSString stringWithFormat:@"%@",[goodsInfoDictionary objectForKey:@"Standard_Price"]]];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"error%@",[completedOperation responseString]);
    }];
    [engine enqueueOperation:op];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSMutableArray *)sellArray
{
    if(_sellArray == nil)
    {
         _sellArray = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:30],[NSNumber numberWithInt:33],[NSNumber numberWithInt:50],[NSNumber numberWithInt:65],[NSNumber numberWithInt:85],[NSNumber numberWithInt:70],[NSNumber numberWithInt:23],[NSNumber numberWithInt:34],[NSNumber numberWithInt:65],[NSNumber numberWithInt:77],[NSNumber numberWithInt:45],[NSNumber numberWithInt:48],[NSNumber numberWithInt:66],[NSNumber numberWithInt:25],[NSNumber numberWithInt:37],[NSNumber numberWithInt:32],[NSNumber numberWithInt:72],[NSNumber numberWithInt:13],[NSNumber numberWithInt:23],[NSNumber numberWithInt:87],[NSNumber numberWithInt:27],[NSNumber numberWithInt:60],[NSNumber numberWithInt:66],[NSNumber numberWithInt:8],[NSNumber numberWithInt:55],[NSNumber numberWithInt:15],[NSNumber numberWithInt:35],[NSNumber numberWithInt:89],[NSNumber numberWithInt:56],[NSNumber numberWithInt:14], nil];
    }
    return _sellArray;
}

- (void)setGraphParam:(CPTXYGraph *)graph
             hostView:(CPTGraphHostingView *)hostView
{
    
    CPTScatterPlot *scatterPlot = [[CPTScatterPlot alloc]initWithFrame:hostView.frame];
    
    //设置坐标轴大小
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-1) length:CPTDecimalFromFloat(32)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-1) length:CPTDecimalFromFloat(100)];
    scatterPlot.dataSource = self;
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit = 1.0f;
    lineStyle.lineWidth = 2.0f;
    [graph addPlot:scatterPlot];
   //
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
    lineStyle.lineColor = [CPTColor colorWithComponentRed:0 green:165/255.0 blue:250/255.0 alpha:1.0];
    scatterPlot.dataLineStyle = lineStyle;
    //构造一个textStyle
    static CPTTextStyle *lableTextStyle = nil;
    lableTextStyle = [[CPTTextStyle alloc]init];
    lableTextStyle.color = [CPTColor colorWithComponentRed:0 green:165/255.0 blue:250/255.0 alpha:1.0];
    lableTextStyle.fontSize = 10.f;
    lableTextStyle.textAlignment = CPTTextAlignmentCenter;
    int count =0;
    for(int i =0;i<35;i +=5)
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
    y.labelTextStyle.color = [CPTColor colorWithComponentRed:0 green:165/255.0 blue:250/255.0 alpha:1.0];
    y.labelTextStyle.fontSize = 10.f;
    //设置小圆点
    //symbleLineStyle.lineColor = [CPTColor blackColor];
    CPTPlotSymbol *plotSymbol = [ CPTPlotSymbol ellipsePlotSymbol ];
    plotSymbol. fill = [ CPTFill fillWithColor :[CPTColor colorWithComponentRed:0 green:165/255.0 blue:250/255.0 alpha:1.0]];
    plotSymbol. lineStyle = nil;
    plotSymbol. size = CGSizeMake ( 5.0 , 5.0 );
    scatterPlot.plotSymbol = plotSymbol;
}


- (NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    if(fieldEnum == CPTScatterPlotFieldX)
    {
        return [NSNumber numberWithInt:index+1];
    }else{
        return [self.sellArray objectAtIndex:index];
    }
}

- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [self.sellArray count];
}
- (void)viewDidUnload {
    [self setNameLabel:nil];
    [self setGoodsIdLabel:nil];
    [self setGoodsTypeLabel:nil];
    [self setStockAmountLabel:nil];
    [self setStockWarnLabel:nil];
    [self setCostPriceLabel:nil];
    [self setInNunLabel:nil];
    [self setGoodsUnitLabel:nil];
    [self setStandardPriceLabel:nil];
    [self setLastYearLabel:nil];
    [super viewDidUnload];
}
@end
