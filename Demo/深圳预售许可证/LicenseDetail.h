//
//  LicenseDetail.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/30.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LicenseDetail : NSObject

@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *company;


@property (nonatomic, copy) NSString *licenseKey;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *grossArea;
@property (nonatomic, copy) NSString *numberOfBuildings;

@property(nonatomic, assign) NSUInteger totalNumberOfHouseholds;

@property (nonatomic, strong) NSMutableArray *allTypesInLicense;

- (void)getLicenseDetailWithDetailUrl:(NSString *)url;

@end
