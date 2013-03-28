//
//  SupplierInformationViewController.h
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupplierInformationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *providerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *providerAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *linkerLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *mobileLabel;
@property (strong, nonatomic) IBOutlet UILabel *faxLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *remarkLabel;
@property (strong, nonatomic) NSMutableDictionary *supplierDictionary;
@end
