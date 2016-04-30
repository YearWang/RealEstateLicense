//
//  ViewController.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/27.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "AllLicensesViewController.h"

@interface AllLicensesViewController ()

@end

@implementation AllLicensesViewController
{
    NSMutableArray *_licenses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    _license = [[NSMutableArray alloc] initWithCapacity:10];
//    
//    License *license;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LicenseCell"];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *districtLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:3];
    UILabel *companyLabel = (UILabel *)[cell viewWithTag:4];
    UILabel *priceLabel = (UILabel *)[cell viewWithTag:5];
    UILabel *quantityLabel = (UILabel *)[cell viewWithTag:6];
    UILabel *numberLabel = (UILabel *)[cell viewWithTag:7];
    
    if (indexPath.row == 0) {
        numberLabel.text = @"1";
        nameLabel.text = @"中骏蓝湾翠岭花园一期";
        districtLabel.text = @"龙岗";
        dateLabel.text = @"2016-04-18";
        companyLabel.text = @"深圳泛亚房地产开发有限公司";
        priceLabel.text = @"23451";
        quantityLabel.text = @"251";
    }else if (indexPath.row == 1){
        numberLabel.text = @"2";
        nameLabel.text = @"佳兆业中央广场三期";
        districtLabel.text = @"龙岗";
        dateLabel.text = @"2016-04-14";
        companyLabel.text = @"宝吉工艺品（深圳）有限公司";
        priceLabel.text = @"12345";
        quantityLabel.text = @"380";
    }
    //@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
    //@property (weak, nonatomic) IBOutlet UILabel *districtLabel;
    //@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
    //@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
    //@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
    //@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
    return cell;
}

@end
