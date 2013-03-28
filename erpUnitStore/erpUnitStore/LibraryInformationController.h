//
//  LibraryInformationController.h
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LibraryInformationController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *goodsIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *createDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *validTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *costMoneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;
@property (strong, nonatomic) IBOutlet UILabel *endDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *inNoteIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *OperatorDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *OperatorIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong ,nonatomic)NSMutableDictionary *libraryInfoDictionary;
@end
