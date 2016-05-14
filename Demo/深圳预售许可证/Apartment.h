//
//  Apartment.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/10.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ONOXMLElement;

@interface Apartment : NSObject <NSCoding>

@property (nonatomic, copy) NSString *apartmentNumberWithSquareMetre;
@property (nonatomic, copy) NSString *apartmentUrl;

@property (nonatomic, copy) NSString *roomNumber;
@property (nonatomic, copy) NSString *kindNumber;
@property (nonatomic ,copy) NSString *floor;
@property (nonatomic, copy) NSString *usage;

@property (nonatomic, assign) float grossFloorArea;
@property (nonatomic, assign) float averagePrice;
@property (nonatomic, assign) float totalPrice;

- (void)apartmentWithHtmlStr:(ONOXMLElement *)element; //给该apartment的 apartmentNumberWithSquareMetre 和 apartmentUrl 属性赋值
- (void)getApartmentDetail;//给该apartment的 其他属性 赋值

@end
