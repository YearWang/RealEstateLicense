//
//  DetailTipsViewController.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/28.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "DetailTipsViewController.h"

@interface DetailTipsViewController ()

@end

@implementation DetailTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
