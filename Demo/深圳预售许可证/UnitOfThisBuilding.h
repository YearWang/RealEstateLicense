//
//  UnitsOfThisBuilding.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/10.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ONOXMLElement;

@interface UnitOfThisBuilding : NSObject <NSCoding>

@property (nonatomic, copy) NSString *buildingUnitName;
@property (nonatomic, copy) NSString *unitUrl;

@property (nonatomic, copy) NSString *mainUsage;
@property (nonatomic, assign) NSUInteger quantityOfMainUsageApartment;
@property (nonatomic, assign) float averagePriceOfMainUsage;

@property (nonatomic, copy) NSMutableArray *apartments;
@property (nonatomic, strong) NSMutableArray *AllKindsOfApartment;

- (void)UnitWithHtmlStr:(ONOXMLElement *)element unitNameByAppendingBuildingName:(NSString *)string; //给该unit各属性赋值

- (NSMutableArray *)getApartments;

-(void)getAveragePriceOfMainUsage;

@end
