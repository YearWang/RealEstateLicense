//
//  BuildingsOfThisLicense.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/10.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "BuildingOfThisLicense.h"
#import "UnitOfThisBuilding.h"
#import <Ono.h>

static NSString *const licenseUrlStr = @"http://ris.szpl.gov.cn/bol/";

@implementation BuildingOfThisLicense

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.everyBuildingName = [aDecoder decodeObjectForKey:@"EveryBuildingName"];
        self.everyBuildingUrl = [aDecoder decodeObjectForKey:@"EveryBuildingUrl"];
        self.units = [aDecoder decodeObjectForKey:@"Units"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.everyBuildingName forKey:@"EveryBuildingName"];
    [aCoder encodeObject:self.everyBuildingUrl forKey:@"EveryBuildingUrl"];
    [aCoder encodeObject:self.units forKey:@"Units"];
}


- (void)buildingsWithHtmlStr:(ONOXMLElement *)element
{
    ONOXMLElement *buildingNameElement = [element firstChildWithXPath:@"td[2]"];
    self.everyBuildingName = [buildingNameElement stringValue];//获取 预售证详情网址
    
    ONOXMLElement *urlElement = [element firstChildWithXPath:@"td[5]/a"]; // 根据 XPath 获取含有文章标题的 a 标签
    NSString *relativeEveryBuildingUrl = [urlElement valueForAttribute:@"href"]; // 获取 项目各栋楼的相对URL
    self.everyBuildingUrl = [NSString stringWithFormat:@"%@%@",licenseUrlStr,relativeEveryBuildingUrl];
}


- (NSMutableArray *)getUnits
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSData *gbkData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.everyBuildingUrl]];//下载主页网页数据
    NSError *error;
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *utf8Str = [[NSString alloc] initWithData:gbkData encoding:enc];
    NSData *data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@第二次",data);
    
    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:&error];
    //NSLog(@"%@",doc);
    
    ONOXMLElement *unitsParentElement = [doc firstChildWithXPath:@"//*[@id='divShowBranch']"]; //寻找该 XPath 代表的 HTML 节点
    
    //遍历其子节点
    [unitsParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *_Nonnull stop) {

        UnitOfThisBuilding *unit = [[UnitOfThisBuilding alloc] init];
        [unit UnitWithHtmlStr:element unitNameByAppendingBuildingName:self.everyBuildingName];
        [array addObject:unit];
    }];
    
    [array[0] setUnitUrl:self.everyBuildingUrl];
    
    for (UnitOfThisBuilding *unit in array) {
        unit.apartments = [unit getApartments];
        [unit getAveragePriceOfMainUsage];
        [unit AllKindsOfApartment];
    }
    return array;
}



@end
