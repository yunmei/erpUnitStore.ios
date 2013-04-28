//
//  popUpBox.m
//  popUpDemo
//
//  Created by bbk on 11-6-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PopupBox.h"

@implementation PopupBox
//@synthesize myNavigationBar;
@synthesize selectContentLabel;
@synthesize hiddenButton;
@synthesize popUpBoxTableView;
@synthesize popUpBoxDatasource;
@synthesize myAlertView;

-(id)initWithFrame:(CGRect)frame delegate:(id<popUpBoxDelegate>)pDelegate Title:(NSString*)title
{
	if ((self = [super initWithFrame: frame])) {
		// 添加一个导航栏
	//	myNavigationBar = [[UINavigationBar alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.height)];
	//	[self addSubview: myNavigationBar];
		UIImage *bgImg = [[UIImage imageNamed:@"combo.png"] stretchableImageWithLeftCapWidth:40 topCapHeight:0];
		
		UIImageView* _bgView = [[UIImageView alloc] initWithImage:bgImg];
		[self addSubview:_bgView];
		_bgView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
		
		
		// 添加一个标签
		selectContentLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, frame.size.width-40, frame.size.height)];
		selectContentLabel.textAlignment = NSTextAlignmentCenter;
		selectContentLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:selectContentLabel];
		
		// 添加一个隐藏的按钮
		hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[hiddenButton setFrame: CGRectMake(0, 0, frame.size.width, frame.size.height)];
		hiddenButton.backgroundColor = [UIColor clearColor];
		[hiddenButton addTarget:self action:@selector(hiddenButtonClicked) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:hiddenButton];
		
		// 添加一个tableView
		popUpBoxTableView = [[UITableView alloc] initWithFrame: CGRectMake(15, 50, 255, 135)];
		popUpBoxTableView.delegate = self;
		popUpBoxTableView.dataSource = self;
		
		// 添加一个alertView
		myAlertView = [[UIAlertView alloc] initWithTitle:title message: @"\n\n\n\n\n\n\n\n" delegate: nil cancelButtonTitle: @"Cancel" otherButtonTitles: nil];
		[myAlertView addSubview: popUpBoxTableView];
		
		self->delegate = pDelegate;
		m_nCuresel = -1;
		
    }
    
	return self;
}

-(void)hiddenButtonClicked {
	
	if ([delegate respondsToSelector:@selector(popUpBox:willEditing:)] ) 
	{
		[delegate popUpBox:self willEditing:0];
	}
	[myAlertView show];
}

#pragma mark table data source delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {	
	int n = [popUpBoxDatasource count];
	return n;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"ListCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
	}
	
	NSString *text = [popUpBoxDatasource objectAtIndex:indexPath.row];
	cell.textLabel.text = text;
	cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
	
	return cell;
}

#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 35.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// 点击使alertView消失
	NSUInteger cancelButtonIndex = myAlertView.cancelButtonIndex;
	[myAlertView dismissWithClickedButtonIndex: cancelButtonIndex animated: YES];
	NSString *selectedCellText = [popUpBoxDatasource objectAtIndex:indexPath.row];
	
	selectContentLabel.text = selectedCellText;		
	m_nCuresel = indexPath.row;
	[delegate popUpBox:self IndexChanged:indexPath.row];

}


-(void)dealloc {

}
@end
