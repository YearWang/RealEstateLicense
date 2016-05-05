//
//  DetailedPriceListViewController.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/1.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "DetailedPriceListViewController.h"
#import "BuildingDetail.h"
#import "License.h"

@interface DetailedPriceListViewController ()

@end

@implementation DetailedPriceListViewController

//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super initWithCoder:aDecoder]) {
//        [self loadBuildingDetails];
//    }
//    return self;
//}

//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super initWithCoder:aDecoder]) {
//        _buildings = [[NSMutableArray alloc] initWithCapacity:20];
//        
//        BuildingDetail *building;
//        
//        building = [[BuildingDetail alloc] init];
//        building.buildingName = @"1栋";
//        building.buildingNumber = @"[5号楼A]";
//        building.buildingMainType = @"住宅";
//        building.buildingHouseholdings = 268;
//        building.buildingPrice = 54877;
//        [_buildings addObject:building];
//        
//        building = [[BuildingDetail alloc] init];
//        building.buildingName= @"5栋";
//        building.buildingNumber = @"[3号楼B]";
//        building.buildingMainType = @"商务公寓";
//        building.buildingHouseholdings = 1256;
//        building.buildingPrice = 102568;
//        [_buildings addObject:building];
//
//    }
//    return self;
//}

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
    
    BuildingDetail *building = self.license.buildings[indexPath.row];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:11];
    UILabel *mainTypeAndHouseholdingsLabel = (UILabel *)[cell viewWithTag:12];
    UILabel *priceLabel = (UILabel *)[cell viewWithTag:13];
    
    nameLabel.text = [NSString stringWithFormat:@"%@-%@",building.buildingName,building.buildingNumber];
    mainTypeAndHouseholdingsLabel.text = [NSString stringWithFormat:@"%@:%lu套",building.buildingMainType,building.buildingHouseholdings];
    priceLabel.text = [NSString stringWithFormat:@"%lu",building.buildingPrice];
    
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
