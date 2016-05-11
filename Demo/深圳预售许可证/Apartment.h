//
//  Apartment.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/10.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ONOXMLElement;

@interface Apartment : NSObject

@property (nonatomic, copy) NSString *apartmentNumberWithSquareMetre;
@property (nonatomic, copy) NSString *apartmentUrl;

@property (nonatomic, copy) NSString *roomNumber;
@property (nonatomic ,copy) NSString *floor;
@property (nonatomic, copy) NSString *usage;
@property (nonatomic, copy) NSString *grossFloorArea;
@property (nonatomic, copy) NSString *averagePrice;

- (void)apartmentWithHtmlStr:(ONOXMLElement *)element; //给该apartment各属性赋值

@end
