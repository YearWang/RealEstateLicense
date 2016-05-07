//
//  licensesDownload.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/7.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ONOXMLElement;

@interface licensesDownload : NSObject
//info of license
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *licenseKey;

@property (nonatomic, copy) NSString *detailUrl;
@property (nonatomic, copy) NSString *buildingUrl;

//info of licenseDetail
@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *grossArea;
@property (nonatomic, copy) NSString *numberOfBuildings;

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *household;



+ (NSMutableArray *)getAllLicenses; //获取所有预售证
+ (instancetype)licenseWithHtmlStr:(ONOXMLElement *)element; //用HTML数据创建License类

- (NSMutableArray *)getLicenseDetailFromDetailUrl:(NSString *)url; //获取一个预售证上的详细信息

@end
