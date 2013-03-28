//
//  SlideViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "SlideViewController.h"
#import "ErpViewController.h"
@interface SlideViewController ()

@end

@implementation SlideViewController
@synthesize pageControl = _pageControl;
@synthesize pageScroll = _pageScroll;
@synthesize gotoMainViewButton;
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
    [self.view addSubview:self.pageScroll];
    [self addImageToScrollView];
    [self.view addSubview:self.pageControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIPageControl *)pageControl
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    if(_pageControl == nil)
    {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(141, size.height-50, 38, 36)];
    }
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
    return _pageControl;
}

-(UIScrollView *)pageScroll
{
    if(_pageScroll == nil)
    {
        _pageScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height)];
    }
    [_pageScroll setContentSize:CGSizeMake(self.view.frame.size.width * 3 , self.view.frame.size.height)];
    _pageScroll.delegate = self;
    _pageScroll.scrollEnabled = YES;
    _pageScroll.pagingEnabled = YES;
    return  _pageScroll;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.view.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth) +1;
    if(scrollView.contentOffset.x == pageWidth * 2)
    {
        self.gotoMainViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.gotoMainViewButton setFrame:CGRectMake(120, 100, 80, 40)];
        [self.gotoMainViewButton setTitle:@"立即体验" forState:UIControlStateNormal];
        [self.gotoMainViewButton setBackgroundColor:[UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:0.3]];
        self.gotoMainViewButton.layer.cornerRadius = 10.0;
        [self.gotoMainViewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:self.gotoMainViewButton];
        [self.gotoMainViewButton addTarget:self action:@selector(gotoMainView:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self.gotoMainViewButton removeFromSuperview];
    }
    if(scrollView.contentOffset.x > pageWidth*2)
    {
        [self gotoMainView];
    }
    self.pageControl.currentPage = page;
}

-(void)addImageToScrollView
{
    UIImageView *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320 , 460)];
    NSLog(@"w%fh%f",self.view.frame.size.width,self.view.frame.size.height);
    [imgView1 setImage:[UIImage imageNamed:@"slide1.jpg"]];
    UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(320, 0, 320, 460)];
    [imgView2 setImage:[UIImage imageNamed:@"slide2.png"]];
    UIImageView *imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(320*2, 0, 320, 460)];
    [imgView3 setImage:[UIImage imageNamed:@"slide3.jpg"]];
    [self.pageScroll addSubview:imgView1];
    [self.pageScroll addSubview:imgView2];
    [self.pageScroll addSubview:imgView3];
//    CGSize size = [UIScreen mainScreen].bounds.size;
//    if(size.height >480)
//    {
//        
//        UIImageView *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height - 20)];
//        NSLog(@"w%fh%f",self.view.frame.size.width,self.view.frame.size.height);
//        [imgView1 setImage:[UIImage imageNamed:@"slide1-568h.png"]];
//        UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(size.width, 0, size.width, size.height - 20) ];
//        [imgView2 setImage:[UIImage imageNamed:@"slide2-568h.png"]];
//        UIImageView *imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(size.width*2, 0, size.width, size.height - 20)];
//        [imgView3 setImage:[UIImage imageNamed:@"slide3-568h.png"]];
//        [self.pageScroll addSubview:imgView1];
//        [self.pageScroll addSubview:imgView2];
//        [self.pageScroll addSubview:imgView3];
//    }else{
//        
//        UIImageView *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height - 20)];
//        NSLog(@"w%fh%f",self.view.frame.size.width,self.view.frame.size.height);
//        [imgView1 setImage:[UIImage imageNamed:@"slide1.png"]];
//        UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(size.width, 0, size.width, size.height - 20)];
//        [imgView2 setImage:[UIImage imageNamed:@"slide2.png"]];
//        UIImageView *imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(size.width*2, 0, size.width, size.height - 20)];
//        [imgView3 setImage:[UIImage imageNamed:@"slide3.png"]];
//        [self.pageScroll addSubview:imgView1];
//        [self.pageScroll addSubview:imgView2];
//        [self.pageScroll addSubview:imgView3];
//    }
    
}

-(void)gotoMainView:(id)sender
{
    ErpViewController *mainView = [[ErpViewController alloc]init];
    [self presentViewController:mainView animated:NO completion:nil];
}

-(void)gotoMainView
{
    ErpViewController *mainView = [[ErpViewController alloc]init];
    [self presentViewController:mainView animated:NO completion:nil];
}

@end
