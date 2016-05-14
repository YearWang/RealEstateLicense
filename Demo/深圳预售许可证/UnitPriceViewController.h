//
//  DetailedPriceListViewController.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/1.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class License;

@interface UnitPriceViewController : UITableViewController

@property (nonatomic, strong) License *license;

- (IBAction)back:(id)sender;

@end
