//
//  DetailedPriceListViewController.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/1.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "UnitPriceViewController.h"
#import "KindsOfApartmentViewController.h"
#import "UnitOfThisBuilding.h"
#import "Apartment.h"
#import "License.h"

@interface UnitPriceViewController ()

@end

@implementation UnitPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.license.name;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //给license的buildings数组属性添加building类
        NSMutableArray *buildings = [self.license getWholeBuildings];
        
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
    
            self.license.buildings = buildings;
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.license.buildings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuildingPriceCell"];
    
    UnitOfThisBuilding *unit = self.license.buildings[indexPath.row];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:11];
    UILabel *mainTypeAndHouseholdingsLabel = (UILabel *)[cell viewWithTag:12];
    UILabel *priceLabel = (UILabel *)[cell viewWithTag:13];
    UILabel *floorLabel = (UILabel *)[cell viewWithTag:14];
    
    if ([[unit.buildingUnitName substringToIndex:2] isEqualToString:@"--"]) {
        NSMutableString *string  = [NSMutableString stringWithString:unit.buildingUnitName];
        [string replaceCharactersInRange:NSMakeRange(0, 2) withString:self.license.name];
        nameLabel.text = string;
    }else{
        nameLabel.text = unit.buildingUnitName;
    }
    mainTypeAndHouseholdingsLabel.text = [NSString stringWithFormat:@"%@:%lu套",unit.mainUsage,(unsigned long)unit.quantityOfMainUsageApartment];
    priceLabel.text = [NSString stringWithFormat:@"%.0f",unit.averagePriceOfMainUsage];
    floorLabel.text = [NSString stringWithFormat:@"单元层数 :%@",[unit.apartments[0] floor]];
    
    return cell;
}


- (IBAction)back:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowKindsOfApartment"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        KindsOfApartmentViewController *controller = (KindsOfApartmentViewController *) navigationController.topViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.unit = self.license.buildings[indexPath.row];
    }
}

@end
