//
//  KindsOfApartmentViewController.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/13.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UnitOfThisBuilding;

@interface KindsOfApartmentViewController : UITableViewController

@property (nonatomic, strong) UnitOfThisBuilding *unit;

- (IBAction)back:(id)sender;

@end
