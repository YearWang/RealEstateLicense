//
//  LicenseDetailsTableTableViewController.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/28.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class License;

@interface LicenseDetailsViewController : UITableViewController

@property (nonatomic, strong) License *license;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;

@property (weak, nonatomic) IBOutlet UILabel *licenseKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *grossAreaLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBuildingsLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel1;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel3;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel4;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel5;

@property (weak, nonatomic) IBOutlet UILabel *areaLabel1;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel2;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel3;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel4;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel5;

@property (weak, nonatomic) IBOutlet UILabel *householdsLabel1;
@property (weak, nonatomic) IBOutlet UILabel *householdsLabel2;
@property (weak, nonatomic) IBOutlet UILabel *householdsLabel3;
@property (weak, nonatomic) IBOutlet UILabel *householdsLabel4;
@property (weak, nonatomic) IBOutlet UILabel *householdsLabel5;

- (IBAction)back:(id)sender;

@end
