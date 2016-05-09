//
//  licensesDownload.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/7.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ONOXMLElement;

@interface LicensesDownload : NSObject

+ (NSMutableArray *)getAllLicenses; //获取所有预售证
+ (NSMutableArray *)getLicenseDetailFromDetailUrl:(NSString *)url; //获取许可证的详细信息
+ (NSMutableArray *)getBuildingsFromBuildingUrl:(NSString *)url; //获取许可证内的各个楼座

@end
