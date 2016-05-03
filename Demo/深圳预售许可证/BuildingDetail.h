//
//  BuildingDetail.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/3.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuildingDetail : NSObject

@property (nonatomic, copy) NSString *buildingName;
@property (nonatomic, copy) NSString *buildingNumber;
@property (nonatomic, copy) NSString *buildingMainType;
@property (nonatomic, assign) NSUInteger buildingHouseholdings;

@property (nonatomic, assign) NSUInteger buildingPrice;


@end
