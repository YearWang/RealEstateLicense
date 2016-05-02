//
//  LicenseDetail.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/30.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LicenseDetail : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *company;


@property (nonatomic, copy) NSString *licenseKey;

@property (nonatomic, copy) NSDate *date;

@property (nonatomic, assign) NSUInteger price;
@property (nonatomic, assign) NSUInteger quantity;

@end
