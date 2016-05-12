//
//  DetailedPriceListViewController.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/1.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "DetailedPriceListViewController.h"
#import "UnitOfThisBuilding.h"
#import "Apartment.h"
#import "License.h"

@interface DetailedPriceListViewController ()

@end

@implementation DetailedPriceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.license.name;
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
//    UILabel *priceLabel = (UILabel *)[cell viewWithTag:13];
    
    if ([[unit.buildingUnitName substringToIndex:2] isEqualToString:@"--"]) {
        NSMutableString *string  = [NSMutableString stringWithString:unit.buildingUnitName];
        [string replaceCharactersInRange:NSMakeRange(0, 2) withString:self.license.name];
        nameLabel.text = string;
    }else{
        nameLabel.text = unit.buildingUnitName;
    }
    mainTypeAndHouseholdingsLabel.text = [NSString stringWithFormat:@"%@:%lu套",unit.mainUsage,(unsigned long)unit.quantityOfMainUsageApartment];
//    priceLabel.text = [NSString stringWithFormat:@"%lu",building.buildingPrice];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
