//
//  popUpBox.h
//  popUpDemo
//
//  Created by bbk on 11-6-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol popUpBoxDelegate;

@interface PopupBox : UIView<UITableViewDelegate, UITableViewDataSource> {
//	UINavigationBar *myNavigationBar;
	UILabel			*selectContentLabel;
	UIButton		*hiddenButton;
	UITableView		*popUpBoxTableView;
	NSArray		    *popUpBoxDatasource;
	UIAlertView		*myAlertView;
	id<popUpBoxDelegate>  delegate;	
@public
	int				data[256];
	int				m_nCuresel;
}

//@property(nonatomic, retain) UINavigationBar *myNavigationBar;
@property(nonatomic, retain) UILabel *selectContentLabel;
@property(nonatomic, retain) UIButton *hiddenButton;
@property(nonatomic, retain) UITableView *popUpBoxTableView;
@property(nonatomic, retain) NSArray *popUpBoxDatasource;
@property(nonatomic, retain) UIAlertView *myAlertView;

-(id)initWithFrame:(CGRect)frame delegate:(id<popUpBoxDelegate>)delegate Title:(NSString*)title;

@end

@protocol popUpBoxDelegate <NSObject>

- (void) popUpBox:(PopupBox *)popUpBox IndexChanged:(NSInteger)index;
- (void) popUpBox:(PopupBox *)popUpBox willEditing:(NSInteger)index;

@end
