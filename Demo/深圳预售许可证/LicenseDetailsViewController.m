//
//  LicenseDetailsTableTableViewController.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/28.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "LicenseDetailsViewController.h"
#import "License.h"
#import "TypeInLicense.h"


@interface LicenseDetailsViewController ()

@end

@implementation LicenseDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.license.name;
    
    self.locationLabel.text          = [NSString stringWithFormat:@"位    置：%@",self.license.licenseDetail.location];
    self.companyLabel.text           = [NSString stringWithFormat:@"开发商：%@",self.license.licenseDetail.company];
    self.licenseKeyLabel.text        = [NSString stringWithFormat:@"许可证号：%@",self.license.licenseDetail.licenseKey];
    self.dateLabel.text              = [NSString stringWithFormat:@"发证日期：%@",self.license.licenseDetail.date];
    self.grossAreaLabel.text         = [NSString stringWithFormat:@"批准面积：%@",self.license.licenseDetail.grossArea];
    self.numberOfBuildingsLabel.text = [NSString stringWithFormat:@"批准栋数：%@ 栋",self.license.licenseDetail.numberOfBuildings];

 
    self.typeLabel1.text = [self.license.licenseDetail.allTypesInLicense[0] kind];
    self.areaLabel1.text = [self.license.licenseDetail.allTypesInLicense[0] area];
    self.householdsLabel1.text = [NSString stringWithFormat:@"%lu套",(unsigned long)[self.license.licenseDetail.allTypesInLicense[0] household]];

    self.typeLabel2.text = [self.license.licenseDetail.allTypesInLicense[1] kind];
    self.areaLabel2.text = [self.license.licenseDetail.allTypesInLicense[1] area];
    if (![self.license.licenseDetail.allTypesInLicense[1] household] == 0) {
            self.householdsLabel2.text = [NSString stringWithFormat:@"%lu套",(unsigned long)[self.license.licenseDetail.allTypesInLicense[1] household]];
    }else{
        self.householdsLabel2.text = @"";
    }
    
    self.typeLabel3.text = [self.license.licenseDetail.allTypesInLicense[2] kind];
    self.areaLabel3.text = [self.license.licenseDetail.allTypesInLicense[2] area];
    if (![self.license.licenseDetail.allTypesInLicense[2] household] == 0) {
        self.householdsLabel3.text = [NSString stringWithFormat:@"%lu套",(unsigned long)[self.license.licenseDetail.allTypesInLicense[2] household]];
    }else{
        self.householdsLabel3.text = @"";
    }
    
    self.typeLabel4.text = [self.license.licenseDetail.allTypesInLicense[3] kind];
    self.areaLabel4.text = [self.license.licenseDetail.allTypesInLicense[3] area];
    if (![self.license.licenseDetail.allTypesInLicense[3] household] == 0) {
        self.householdsLabel4.text = [NSString stringWithFormat:@"%lu套",(unsigned long)[self.license.licenseDetail.allTypesInLicense[3] household]];
    }else{
        self.householdsLabel4.text = @"";
    }
    
    self.typeLabel5.text = [self.license.licenseDetail.allTypesInLicense[4] kind];
    self.areaLabel5.text = [self.license.licenseDetail.allTypesInLicense[4] area];
    if (![self.license.licenseDetail.allTypesInLicense[4] household] == 0) {
        self.householdsLabel5.text = [NSString stringWithFormat:@"%lu套",(unsigned long)[self.license.licenseDetail.allTypesInLicense[4] household]];
    }else{
        self.householdsLabel5.text = @"";
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources thwat can be recreated.
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
