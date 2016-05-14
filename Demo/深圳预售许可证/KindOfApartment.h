//
//  KindOfApartment.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/13.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Apartment;

@interface KindOfApartment : NSObject

@property (nonatomic, copy) NSString *numberOfTheKind;
@property (nonatomic, assign) float averagePriceOfTheKind;

@end
