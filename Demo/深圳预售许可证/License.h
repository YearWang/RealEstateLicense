//
//  License.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/29.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface License : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *company;

@property (nonatomic, assign) NSUInteger price;
@property (nonatomic, assign) NSUInteger quantity;

@property (nonatomic, strong) NSMutableArray *buildings;
@property (nonatomic, strong) NSMutableArray *licenseDetail;

@end
