//
//  KindsOfApartmentViewController.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/13.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "KindsOfApartmentViewController.h"
#import "UnitOfThisBuilding.h"
#import "KindOfApartment.h"

@interface KindsOfApartmentViewController ()

@end

@implementation KindsOfApartmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.unit.buildingUnitName;
    [self.unit AllKindsOfApartment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.unit.AllKindsOfApartment count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KindOfApartmentCell"];
    
    KindOfApartment *kind = self.unit.AllKindsOfApartment[indexPath.row];
    
    UILabel *kindNameLabel = (UILabel *)[cell viewWithTag:21];
    UILabel *kindPriceLabel = (UILabel *)[cell viewWithTag:22];
    
    kindNameLabel.text = [NSString stringWithFormat:@"%@ 户型",kind.numberOfTheKind];
    kindPriceLabel.text = [NSString stringWithFormat:@"%.2f",kind.averagePriceOfTheKind];
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (IBAction)back:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
