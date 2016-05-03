//
//  ViewController.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/27.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "AllLicensesViewController.h"
#import "DetailedPriceListViewController.h"
#import "License.h"

@interface AllLicensesViewController ()

@end

@implementation AllLicensesViewController
{
    NSMutableArray *_licenses;
}

- (void)loadLicenses
{
    NSString *path = [self dataFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
    
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        _licenses = [unarchiver decodeObjectForKey:@"Licenses"];
        [unarchiver finishDecoding];
        
    }else{
        
        _licenses = [[NSMutableArray alloc] initWithCapacity:20];
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self loadLicenses];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    _licenses = [[NSMutableArray alloc] initWithCapacity:20];
    
    License *license;
    
    license = [[License alloc] init];
    license.name = @"中骏蓝湾翠岭花园一期";
    license.district = @"龙岗";
    license.date = [NSDate date];
    license.company = @"深圳泛亚房地产开发有限公司";
    license.price = 34521;
    license.quantity = 1450;
    [_licenses addObject:license];
    
    license = [[License alloc] init];
    license.name = @"佳兆业中央广场三期";
    license.district = @"龙岗";
    license.date = [NSDate date];
    license.company = @"宝吉工艺品（深圳）有限公司";
    license.price = 12345;
    license.quantity = 380;
    [_licenses addObject:license];
     */
}

- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}

- (NSString *)dataFilePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"License.plist"];
}

- (void)saveLicenses
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_licenses forKey:@"Licenses"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_licenses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LicenseCell"];
    
    License *license = _licenses[indexPath.row];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *districtLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:3];
    UILabel *companyLabel = (UILabel *)[cell viewWithTag:4];
    UILabel *priceLabel = (UILabel *)[cell viewWithTag:5];
    UILabel *quantityLabel = (UILabel *)[cell viewWithTag:6];
    UILabel *numberLabel = (UILabel *)[cell viewWithTag:7];
    
    numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    nameLabel.text = license.name;
    districtLabel.text = [NSString stringWithFormat:@"所在区域:%@",license.district];
    
    //转换日期格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd"];
    NSString *dateString = [dateFormatter stringFromDate:license.date];
    
    dateLabel.text = [NSString stringWithFormat:@"批准时间:%@",dateString];
    companyLabel.text = [NSString stringWithFormat:@"开发企业:%@",license.company];
    priceLabel.text = [NSString stringWithFormat:@"%ld",license.price];
    quantityLabel.text = [NSString stringWithFormat:@"%ld",license.quantity];

    [self saveLicenses];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    License *license = _licenses[indexPath.row];
    [self performSegueWithIdentifier:@"ShowBuildingPrice" sender:license];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowBuildingPrice"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        DetailedPriceListViewController *controller = (DetailedPriceListViewController *) navigationController.topViewController;
        controller.license = sender;
    }
}

@end
