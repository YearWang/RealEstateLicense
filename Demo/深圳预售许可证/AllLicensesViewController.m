//
//  ViewController.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/27.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "AllLicensesViewController.h"
#import "UnitPriceViewController.h"
#import "License.h"
#import "DateModel.h"

@interface AllLicensesViewController ()

@end

@implementation AllLicensesViewController

#pragma mark - 数据加载和保存


#pragma maik - init初始化


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataModel.licenses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LicenseCell"];
    
    License *license = self.dataModel.licenses[indexPath.row];
    
    UILabel *nameLabel     = (UILabel *)[cell viewWithTag:1];
    UILabel *districtLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *dateLabel     = (UILabel *)[cell viewWithTag:3];
    UILabel *companyLabel  = (UILabel *)[cell viewWithTag:4];
    UILabel *quantityLabel = (UILabel *)[cell viewWithTag:6];
    UILabel *numberLabel   = (UILabel *)[cell viewWithTag:7];
    
    numberLabel.text   = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    nameLabel.text     = license.name;
    districtLabel.text = [NSString stringWithFormat:@"所在区域:%@",license.district];
    
    //转换日期格式
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-mm-dd"];
//    NSString *dateString = [dateFormatter stringFromDate:license.date];
    
    dateLabel.text     = [NSString stringWithFormat:@"批准时间:%@",license.date];
    companyLabel.text  = [NSString stringWithFormat:@"开发企业:%@",license.company];
    quantityLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)license.quantity];

    return cell;
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowBuildingPrice"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        UnitPriceViewController *controller = (UnitPriceViewController *) navigationController.topViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.license = self.dataModel.licenses[indexPath.row];
        
    }else if ([segue.identifier isEqualToString:@"ShowLicenseDetail"]){
        
        UINavigationController *navigationController = segue.destinationViewController;
        UnitPriceViewController *controller = (UnitPriceViewController *) navigationController.topViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.license = self.dataModel.licenses[indexPath.row];
    }
}

@end
