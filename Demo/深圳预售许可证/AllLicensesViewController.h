//
//  ViewController.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/27.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "License.h"

@interface AllLicensesViewController : UITableViewController

//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *districtLabel;
//@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
//@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
//@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

@property (nonatomic, strong) License *license;

@end

