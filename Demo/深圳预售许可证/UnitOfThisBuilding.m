//
//  UnitsOfThisBuilding.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/10.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "UnitOfThisBuilding.h"
#import "Apartment.h"
#import "KindOfApartment.h"
#import <Ono.h>

static NSString *const licenseUrlStr = @"http://ris.szpl.gov.cn/bol/";

@implementation UnitOfThisBuilding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.buildingUnitName = [aDecoder decodeObjectForKey:@"BuildingUnitName"];
        self.unitUrl = [aDecoder decodeObjectForKey:@"UnitUrl"];
        self.mainUsage = [aDecoder decodeObjectForKey:@"MainUsage"];
        self.apartments = [aDecoder decodeObjectForKey:@"Apartments"];
        self.quantityOfMainUsageApartment = [aDecoder decodeIntegerForKey:@"QuantityOfMainUsageApartment"];
        self.averagePriceOfMainUsage = [aDecoder decodeFloatForKey:@"AveragePriceOfMainUsage"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.buildingUnitName forKey:@"BuildingUnitName"];
    [aCoder encodeObject:self.unitUrl forKey:@"UnitUrl"];
    [aCoder encodeObject:self.mainUsage forKey:@"MainUsage"];
    [aCoder encodeObject:self.apartments forKey:@"Apartments"];
    [aCoder encodeInteger:self.quantityOfMainUsageApartment forKey:@"QuantityOfMainUsageApartment"];
    [aCoder encodeFloat:self.averagePriceOfMainUsage forKey:@"AveragePriceOfMainUsage"];

}

- (void)UnitWithHtmlStr:(ONOXMLElement *)element unitNameByAppendingBuildingName:(NSString *)string//给该unit各属性赋值
{
    NSString *relativeUnitUrl = [element valueForAttribute:@"href"];//获取 预售证详情的相对URL
    self.unitUrl = [NSString stringWithFormat:@"%@%@",licenseUrlStr,relativeUnitUrl];
    
    self.buildingUnitName = [NSString stringWithFormat:@"%@-%@",string,[element stringValue]];//获取 预售证详情网址
}


- (NSArray *)getApartments
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSData *gbkData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.unitUrl]];//下载主页网页数据
    NSError *error;
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *utf8Str = [[NSString alloc] initWithData:gbkData encoding:enc];
    NSData *data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:&error];
    
    ONOXMLElement *apartmentParentElement = [doc firstChildWithXPath:@"//div[@id='divShowList']"]; //寻找该 XPath 代表的 HTML 节点
    //遍历其子节点
    [apartmentParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *_Nonnull stop) {

        [element.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *_Nonnull stop) {
            
            Apartment *apartment = [[Apartment alloc] init];
            [apartment apartmentWithHtmlStr:element];
            if (apartment.apartmentUrl) {
                [apartment getApartmentDetail];
                [array addObject:apartment];
            }
            
        }];
        
    }];
    
    NSMutableArray *array1 = [[NSMutableArray alloc] init];//住宅
    NSMutableArray *array2 = [[NSMutableArray alloc] init];//商业
    NSMutableArray *array3 = [[NSMutableArray alloc] init];//商务公寓
    NSMutableArray *array4 = [[NSMutableArray alloc] init];//办公
    NSMutableArray *array5 = [[NSMutableArray alloc] init];//商务办公
    NSMutableArray *array6 = [[NSMutableArray alloc] init];//商业性办公
    NSMutableArray *array7 = [[NSMutableArray alloc] init];//研发用房
    NSMutableArray *array8 = [[NSMutableArray alloc] init];//其他

    for (Apartment *apartment in array)
    {
        if ([apartment.usage containsString:@"住宅"]) {
            [array1 addObject:apartment];
        }else if ([apartment.usage containsString:@"住宅"]){
            [array2 addObject:apartment];
        }else if ([apartment.usage containsString:@"商务公寓"]){
            [array3 addObject:apartment];
        }else if ([apartment.usage containsString:@"办公"]){
            [array4 addObject:apartment];
        }else if ([apartment.usage containsString:@"商务办公"]){
            [array5 addObject:apartment];
        }else if ([apartment.usage containsString:@"商业性办公"]){
            [array6 addObject:apartment];
        }else if ([apartment.usage containsString:@"研发用房"]){
            [array7 addObject:apartment];
        }else{
            [array8 addObject:apartment];
        }
    }
    
    NSArray *maximalArray = [[NSArray alloc] init];
    NSArray *allArray = @[array1,array2,array3,array4,array5,array6,array7,array8];
    
    for (NSMutableArray *arr in allArray) {
        if (arr.count >= maximalArray.count) {
            maximalArray = arr;
        }
    }
    return maximalArray;
}

- (NSString *)mainUsage
{
    return [self.apartments[0] usage];
}

- (NSUInteger)quantityOfMainUsageApartment
{
    return [self.apartments count];
}

- (void)getAveragePriceOfMainUsage
{
    float total = 0.00;
    float totalGross = 0.00;
    for (Apartment *apartment in self.apartments) {
        total += apartment.totalPrice;
        totalGross += apartment.grossFloorArea;
    }
    
//    NSLog(@"%.2f,%.2f",total,totalGross);
    
    self.averagePriceOfMainUsage = total/totalGross;
    //NSLog(@"%.2f",self.averagePriceOfMainUsage);
}

- (NSMutableArray *)AllKindsOfApartment
{
    NSMutableArray *allKinds = [[NSMutableArray alloc]init];
    for (Apartment *apartment in self.apartments) {
        if (!allKinds) {
            NSMutableArray *kind = [NSMutableArray arrayWithObject:apartment];
            [allKinds addObject:kind];
        }else{
            int i = 0;
            int n = 0 ;
            for (NSMutableArray *kind in allKinds) {
                i += kind.count;
                NSString *kindString = [[kind firstObject] kindNumber];
                if ([apartment.kindNumber isEqualToString:kindString]) {
                    [kind addObject:apartment];
                }
                n += kind.count;
            }
            if (i == n) {
                NSMutableArray *kind = [NSMutableArray arrayWithObject:apartment];
                [allKinds addObject:kind];
            }
        }
    }
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    for (NSMutableArray *kind in allKinds) {
        KindOfApartment *kindOfApartment = [[KindOfApartment alloc]init];
        kindOfApartment.numberOfTheKind = [[kind firstObject] kindNumber];
        float totalPrice = 0;
        float totalGorssArea = 0;
        
        for (Apartment *apartment in kind) {
            totalPrice += apartment.totalPrice;
            totalGorssArea += apartment.grossFloorArea;
        }
        kindOfApartment.averagePriceOfTheKind = totalPrice/totalGorssArea;
        
        [array addObject:kindOfApartment];
    }
    return array;
}


@end
