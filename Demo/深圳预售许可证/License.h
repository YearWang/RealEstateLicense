//
//  License.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/29.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LicenseDetail.h"
@class ONOXMLElement;

@interface License : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *company;

@property (nonatomic, assign) NSUInteger quantity;

@property (nonatomic, strong) NSMutableArray *buildings;
@property (nonatomic, strong) LicenseDetail *licenseDetail;

@property (nonatomic, copy) NSString *detailUrl;
@property (nonatomic, copy) NSString *buildingUrl;

- (void)licenseWithHtmlStr:(ONOXMLElement *)element; //用HTML数据创建License类

- (NSMutableArray *)getWholeBuildings;//用HTML数据获取building类

@end
